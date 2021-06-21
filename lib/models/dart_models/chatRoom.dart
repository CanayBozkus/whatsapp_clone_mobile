import 'package:whatsapp_clone_mobile/models/dart_models/contact.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/message.dart';
import 'package:whatsapp_clone_mobile/services/file_manager.dart';
import 'package:whatsapp_clone_mobile/services/network/http_request_data.dart';
import 'package:whatsapp_clone_mobile/services/network/network_manager.dart';


class ChatRoom {
  String id;
  int unReadMessageCount = 0;
  Contact contact;
  Message lastMessage;
  bool isMuted = false;
  List<Message> messages = [];
  bool isSavedLocalDatabase = false;
  List<String> membersPhoneNumber = [];

  Future<bool> sendMessage(Message message) async {
    String uri = 'send-message';
    HttpRequestData data = HttpRequestData();
    Map fields = {
      'message': message.message,
      'roomId': message.roomId,
      'sendTime': message.sendTime.toIso8601String(),
      'from': message.from,
      'membersPhoneNumber': membersPhoneNumber
    };
    data.addFieldsWithMap(fields);

    if(message.file != null){
      message.file = await fileManager.copyImageToExternalStorage(message.file, 'Whatsapp-Clone-${DateTime.now()}.jpg');
      message.fileLocation = message.file.path;

      data.addField(key: 'haveFile', field: 'true');
      data.addFile(
        key: 'imageFile',
        file: message.file,
        type: MultipartFileTypes.image,
        subtype: MultipartFileSubTypes.jpg,
      );
    }
    Map response = await networkManager.sendPostRequest(uri: uri, requestData: data);

    if(response['success']){
      message.isSent = true;
    }

    return response['success'];
  }

  void save(){
    this.isSavedLocalDatabase = true;
  }

  Future<void> sendMessagesSeenInfo() async {
    Map fields = {
      'seenTime': DateTime.now().toIso8601String(),
      'roomId': id,
      'membersPhoneNumber': membersPhoneNumber
    };
    HttpRequestData data = HttpRequestData();

    data.addFieldsWithMap(fields);
    Map response = await networkManager.sendPostRequest(uri: 'send-messages-seen-info', requestData: data);
  }

  void messagesSeenHandler(DateTime seenTime, String userPhoneNumber){
    for(Message message in messages){
      //TODO: sendTime gives 2 second error

      if(message.from == userPhoneNumber && !message.isSeen && message.sendTime.isBefore(seenTime.add(Duration(seconds: 2, milliseconds: 1)))){
        message.isSeen = true;
        message.save();
      }
      else if(message.from == userPhoneNumber && message.isSeen){
        break;
      }
    }
  }

  String getNotificationBody(String userPhoneNumber){
    List<String> unreadMessages = [];

    for(int i = 0; i < unReadMessageCount; i++){
      unreadMessages.add(messages[i].message);
    }

    unreadMessages = unreadMessages.reversed.toList();

    return unreadMessages.join('\n');
  }

  Future<void> sendMessageReceivedInfo({String userPhoneNumber}) async {
    Map fields = {
      'receivedTime': DateTime.now().toIso8601String(),
      'roomId': id,
      'messageOwnerPhoneNumber': lastMessage.from,
      'messageReceiverPhoneNumber': userPhoneNumber
    };
    HttpRequestData data = HttpRequestData();
    data.addFieldsWithMap(fields);
    Map response = await networkManager.sendPostRequest(uri: 'send-messages-received-info', requestData: data);
  }

  void messagesReceivedHandler(DateTime receivedTime, String userPhoneNumber, String receiverPhoneNumber){
    for(Message message in messages){
      //TODO: sendTime gives 2 second error

      if(message.from == userPhoneNumber && !message.isReceived && message.sendTime.isBefore(receivedTime.add(Duration(seconds: 2, milliseconds: 1)))){
        message.isReceived = true;
        message.receivers.add(receiverPhoneNumber);
        message.save();
      }
      else if(message.from == userPhoneNumber && message.isReceived){
        break;
      }
    }
  }
}