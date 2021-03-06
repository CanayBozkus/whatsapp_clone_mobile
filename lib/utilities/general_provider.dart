
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/chatRoom.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/contact.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/message.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/user.dart';
import 'package:whatsapp_clone_mobile/models/hive_models/hive_device.dart';
import 'package:whatsapp_clone_mobile/services/contact_manager.dart';
import 'package:whatsapp_clone_mobile/services/fcm.dart';
import 'package:whatsapp_clone_mobile/services/file_manager.dart';
import 'package:whatsapp_clone_mobile/services/local_database_manager.dart';
import 'package:whatsapp_clone_mobile/services/network/http_request_data.dart';
import 'package:whatsapp_clone_mobile/services/network/network_manager.dart';
import 'package:whatsapp_clone_mobile/services/notification_plugin.dart';
import 'package:whatsapp_clone_mobile/services/sharedPreferences.dart';
import 'package:whatsapp_clone_mobile/services/socket.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class GeneralProvider with ChangeNotifier{
  GeneralProvider(){
    notificationPlugin.setListenerForLowerVersions(() {});
    notificationPlugin.setOnNotificationClick((String payload) {});
  }

  int _mainScreenIndex = 1;
  bool mainScreenNavigatorClicked = false;
  SocketIO _socket;
  ContactManager _contactManager = ContactManager();
  String _jwt;
  User _user = User();
  List<Contact> _contacts;
  HiveDevice _deviceSettings;
  Directory _path;
  List<ChatRoom> _chatRooms = [];
  ChatRoom _currentChatRoom;
  List<Contact> _listenedToContacts = [];

  int get mainScreenIndex => this._mainScreenIndex;
  set mainScreenIndex(int index){
    if(index >= 0 && index <4){
      this._mainScreenIndex = index;
      notifyListeners();
    }
  }

  User get user => this._user;

  List<Contact> get contacts => this._contacts;

  List<ChatRoom> get chatRooms => this._chatRooms;

  Future<void> initialize() async {
    SharedPreferences pref = await getPreference();

    _jwt = pref.getString('jwt');
    networkManager.init(_jwt);
    _path = await getApplicationDocumentsDirectory();

    _deviceSettings = localDatabaseManager.getDeviceSettings();
    await _user.getData(_path);

    _contacts = Contact.getSavedContacts(_path);

    await refreshContactList();

    resumingAppHandler();

    fcmManager.foregroundListener(fcmOnMessageHandler);
    fcmManager.backgroundListener(fcmOnBackgroundMessageHandler);
    //_socket.setChannelHandler('message', socketMessageHandler);
    //_socket.setChannelHandler('message-seen', socketMessagesSeenHandler);
  }

  Future<bool> register(User user) async {
    bool res = await user.register();
    return res;
  }

  Future<bool> login(User user) async {
    Directory path = await getApplicationDocumentsDirectory();
    bool success = await user.login(path.path);
    return success;
  }

  Future<void> refreshContactList() async {
    //TODO: get profile image for new contact
    List<Map> deviceContacts = await _contactManager.getAllContacts();
    List<String> removedContactsPhoneNumber = [];
    bool isChanged = Contact.checkIfContactNameChangedOrContactDeleted(deviceContacts, _contacts, removedContactsPhoneNumber);

    List<Map> newDeviceContacts = Contact.checkNewContacts(deviceContacts, _contacts);
    List newDeviceContactsPhoneNumber = newDeviceContacts.map((e) => e['phoneNumber']).toList();

    if(isChanged){
      await localDatabaseManager.clearContactList();
      _contacts.forEach((Contact contact) {
        contact.save();
      });
    }

    if(newDeviceContacts.isEmpty){
      return;
    }

    List registeredUsers = await Contact.checkAndUpdateContactListFromCloud(jwt: _jwt, newContactsPhoneNumber: newDeviceContactsPhoneNumber, removedContactsPhoneNumber: removedContactsPhoneNumber);

    if(registeredUsers.isNotEmpty){
      for(var registeredUser in registeredUsers){
        Map deviceContact = newDeviceContacts.firstWhere((element) => element['phoneNumber'] == registeredUser['phoneNumber']);
        Contact contact = Contact();
        contact.name = deviceContact['name'];
        contact.phoneNumber = deviceContact['phoneNumber'];
        contact.about = registeredUser['about'];
        contact.isInContactList = true;
        contact.haveProfilePicture = registeredUser['haveProfilePicture'];

        if(contact.haveProfilePicture){
          String imageName = '${contact.phoneNumber}_profile_picture';
          contact.profilePicture = await fileManager.saveByteImage(registeredUser['profilePicture'], imageName);
        }
        _contacts.add(contact);
        contact.save();
      }
    }

  }

  ChatRoom getChatRoomFromContact(Contact contact){
    ChatRoom room = _chatRooms.firstWhere((ChatRoom e) => e.contact == contact, orElse: () => null);

    if(room == null){
      room = ChatRoom();
      room.contact = contact;
      room.id = '${_user.phoneNumber}-${contact.phoneNumber}';
      room.membersPhoneNumber = [_user.phoneNumber, contact.phoneNumber];
      _chatRooms.add(room);
      notifyListeners();
    }

    return room;
  }

  Future<void> sendMessage(ChatRoom room, Message message) async {
    message.sendTime = DateTime.now();
    message.roomId = room.id;
    message.from = _user.phoneNumber;

    room.messages.insert(0, message);
    room.lastMessage = message;
    notifyListeners();

    bool success = await room.sendMessage(message);

    room.save();
    notifyListeners();
  }

  Future<void> receivedMessageHandler(data) async {
    Message message = Message.getMessageFromSocketData(data);

    ChatRoom room = _chatRooms.firstWhere((ChatRoom r) => r.id == message.roomId, orElse: () => null);

    if(room == null){
      room = await createNoneExistChatRoomFromMessage(message);
      notificationPlugin.showNotification(
        id: _chatRooms.length,
        title: room.contact.name,
        body: room.getNotificationBody(_user.phoneNumber),
        payload: "payload",
      );
      room.sendMessageReceivedInfo(userPhoneNumber: _user.phoneNumber);
      notifyListeners();
      return;
    }

    room.messages.insert(0, message);
    room.lastMessage = message;
    room.sendMessageReceivedInfo(userPhoneNumber: _user.phoneNumber);

    if(_currentChatRoom != room){
      room.unReadMessageCount++;
      print(_chatRooms.length);
      notificationPlugin.showNotification(
        id: _chatRooms.indexOf(room),
        title: room.contact.name,
        body: room.getNotificationBody(_user.phoneNumber),
        payload: "payload",
      );
    }
    else {
      room.sendMessagesSeenInfo();
    }
    notifyListeners();
    return;
  }

  Future<ChatRoom> createNoneExistChatRoomFromMessage(Message message) async {
    ChatRoom room = ChatRoom();

    room.id = message.roomId;
    room.lastMessage = message;
    room.messages.insert(0, message);
    room.membersPhoneNumber = [_user.phoneNumber, message.from];
    room.unReadMessageCount++;

    Contact contact = _contacts.firstWhere((Contact e) => e.phoneNumber == message.from, orElse: () => null);
    
    if(contact == null){
      contact = await Contact.getAndSaveUnlistedContactDataFromCloud(phoneNumber: message.from, path: _path.path, userPhoneNumber: _user.phoneNumber);
      _contacts.add(contact);
    }

    room.contact = contact;
    room.save();
    _chatRooms.add(room);

    return room;
  }

  void openAndCloseChatRoomHandler(ChatRoom room) async {
    if(room == null){
      _currentChatRoom = null;
      notifyListeners();
      return;
    }

    if(!_listenedToContacts.contains(room.contact)){
      room.contact.subscribeStatusChannel();
      /*
      _socket.setChannelHandler('${room.contact.phoneNumber}-status-channel', (data){
        room.contact.isOnline = data['isOnline'];
        room.contact.lastSeenTime = data['lastSeenTime'] != null ? DateTime.parse(data['lastSeenTime']) : null;
        notifyListeners();
      });*/
      await room.contact.checkContactStatus(userPhoneNumber: _user.phoneNumber, callback: () => notifyListeners());
      _listenedToContacts.add(room.contact);
    }

    if(room.unReadMessageCount > 0){
      room.sendMessagesSeenInfo();
      room.unReadMessageCount = 0;
    }

    _currentChatRoom = room;
  }

  void closingAppHandler(){
    networkManager.sendPostRequest(
      uri: 'disconnect',
    );

    _listenedToContacts.forEach((Contact contact) {
      contact.unsubscribeStatusChannel();
    });
  }

  void resumingAppHandler() async {
    HttpRequestData data = HttpRequestData();
    data.addField(key: "phoneNumber", field: _user.phoneNumber);
    networkManager.sendPostRequest(
      requestData: data,
      uri: 'connect',
    );

    if(_currentChatRoom != null){
      await _currentChatRoom.contact.checkContactStatus(userPhoneNumber: _user.phoneNumber, callback: () => notifyListeners());
      _listenedToContacts.add(_currentChatRoom.contact);
      _currentChatRoom.contact.subscribeStatusChannel();
    }
  }
  
  void connectSocket(){
    if(_socket == null){
      _socket = SocketIO(jwt: _jwt);
      _socket.connect((){});
      return;
    }
    _socket.connect((){});
  }

  void messagesSeenHandler(data) async {
    DateTime seenTime = DateTime.parse(data['seenTime']);
    String roomId = data['roomId'];

    ChatRoom room = _chatRooms.firstWhere((ChatRoom e) => e.id == roomId, orElse: () => null);

    if(room == null) return;
    room.messagesSeenHandler(seenTime, _user.phoneNumber);
    notifyListeners();
  }

  void sentMessagesReceivedHandler(data){
    DateTime receivedTime = DateTime.parse(data['receivedTime']);
    String roomId = data['roomId'];
    String receiverPhoneNumber = data['messageReceiverPhoneNumber'];

    ChatRoom room = _chatRooms.firstWhere((ChatRoom e) => e.id == roomId, orElse: () => null);

    if(room == null) return;
    room.messagesReceivedHandler(receivedTime, _user.phoneNumber, receiverPhoneNumber);
    notifyListeners();
  }
  
  void fcmForegroundHandler(RemoteMessage event){
    if(event.from.contains('topics')){
      String topic = event.from.substring('/topics/'.length);

      if(topic.contains('status-channel')){
        Contact contact = _listenedToContacts.firstWhere((Contact e) => e.statusChannel == topic);
        contact.isOnline = event.data['isOnline'] == 'true';
        contact.lastSeenTime = event.data.keys.contains('lastSeenTime')  ? DateTime.parse(event.data['lastSeenTime']) : null;
        notifyListeners();
      }

      return;
    }

    String typeNumber = event.data['type'];
    FCMTypes type = Constant.fcmTypesMatches[typeNumber];

    switch(type){
      case FCMTypes.message:
        receivedMessageHandler(event.data);
        return;
      case FCMTypes.messageSeen:
        messagesSeenHandler(event.data);
        return;
      case FCMTypes.messageReceived:
        sentMessagesReceivedHandler(event.data);
        return;
      default:
        return;
    }
  }
  
  void fcmBackgroundHandler(RemoteMessage event){
    generalProvider.receivedMessageHandler(event.data);
  }
}

GeneralProvider generalProvider = GeneralProvider();

void fcmOnMessageHandler(RemoteMessage event){
  generalProvider.fcmForegroundHandler(event);
}

Future<void> fcmOnBackgroundMessageHandler(RemoteMessage event) async {
  generalProvider.fcmBackgroundHandler(event);
}