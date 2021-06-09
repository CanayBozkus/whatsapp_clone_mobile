
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
import 'package:whatsapp_clone_mobile/services/network_manager.dart';
import 'package:whatsapp_clone_mobile/services/notification_plugin.dart';
import 'package:whatsapp_clone_mobile/services/sharedPreferences.dart';
import 'package:whatsapp_clone_mobile/services/socket.dart';

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

    connectSocket();

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

    if(!_chatRooms.contains(room)){
      _chatRooms.add(room);
      room.save();
    }
    notifyListeners();
  }

  Future<void> socketMessageHandler(data) async {
    Message message = Message.getMessageFromSocketData(data);

    ChatRoom room = _chatRooms.firstWhere((ChatRoom r) => r.id == message.roomId, orElse: () => null);

    if(room != null){
      room.messages.insert(0, message);
      room.lastMessage = message;
      if(_currentChatRoom != room){
        room.unReadMessageCount++;
      }
      else {
        room.sendMessagesSeenInfo();
      }
      notificationPlugin.showNotification(
        id: 0,
        title: room.contact.name,
        body: message.message,
        payload: "payload",
      );
      notifyListeners();
      return;
    }

    room = await createNoneExistChatRoomFromMessage(message);
    notificationPlugin.showNotification(
      id: room.unReadMessageCount,
      title: room.contact.name,
      body: message.message,
      payload: "payload",
    );
    notifyListeners();
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
      _socket.setChannelHandler('${room.contact.phoneNumber}-status-channel', (data){
        room.contact.isOnline = data['isOnline'];
        room.contact.lastSeenTime = data['lastSeenTime'] != null ? DateTime.parse(data['lastSeenTime']) : null;
        notifyListeners();
      });
      await room.contact.checkContactStatus(userPhoneNumber: _user.phoneNumber, callback: () => notifyListeners());
      _listenedToContacts.add(room.contact);
    }

    if(room.unReadMessageCount > 0){
      room.sendMessagesSeenInfo();
      room.unReadMessageCount = 0;
    }

    _currentChatRoom = room;
  }

  void disconnectSocket(){
    _socket.disconnect();
  }
  
  void connectSocket(){
    if(_socket == null){
      _socket = SocketIO(jwt: _jwt);
      _socket.connect((){});
      return;
    }
    _socket.connect((){});
  }

  void socketMessagesSeenHandler(data) async {
    DateTime seenTime = DateTime.parse(data['seenTime']);
    String roomId = data['roomId'];

    ChatRoom room = _chatRooms.firstWhere((ChatRoom e) => e.id == roomId, orElse: () => null);

    if(room == null) return;
    room.messagesSeenHandler(seenTime, _user.phoneNumber);
    notifyListeners();
  }
}

GeneralProvider generalProvider = GeneralProvider();

void fcmOnMessageHandler(RemoteMessage event){
  generalProvider.socketMessageHandler(event.data);
}

Future<void> fcmOnBackgroundMessageHandler(RemoteMessage event) async {
  generalProvider.socketMessageHandler(event.data);
}