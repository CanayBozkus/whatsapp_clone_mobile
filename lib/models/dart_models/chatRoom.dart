import 'package:whatsapp_clone_mobile/models/dart_models/contact.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/message.dart';
import 'package:whatsapp_clone_mobile/services/file_manager.dart';
import 'package:whatsapp_clone_mobile/services/network/multipart_data.dart';
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
    Map fields = {
      'message': message.message,
      'roomId': message.roomId,
      'sendTime': message.sendTime.toIso8601String(),
      'from': message.from,
      'membersPhoneNumber': membersPhoneNumber
    };
    Map response;

    if(message.file != null){
      message.file = await fileManager.copyImageToExternalStorage(message.file, 'Whatsapp-Clone-${DateTime.now()}.jpg');
      message.fileLocation = message.file.path;

      MultipartData data = MultipartData();
      fields['haveFile'] = 'true';
      data.addFieldsWithMap(fields);
      data.addFile(
        key: 'imageFile',
        file: message.file,
        type: MultipartFileTypes.image,
        subtype: MultipartFileSubTypes.jpg,
      );

      response = await networkManager.sendPostMultipartRequestWithLogin(uri: uri, multipartData: data);
    }
    else {
      response = await networkManager.sendPostJSONRequestWithLogin(body: fields, uri: uri);
    }
print(response);
    if(response['success']){
      message.isSent = true;
    }

    return response['success'];
  }

  void save(){
    this.isSavedLocalDatabase = true;
  }

  Future<void> sendMessagesSeenInfo() async {
    Map response = await networkManager.sendPostJSONRequestWithLogin(
      uri: 'send-messages-seen-info',
      body: {
        'seenTime': DateTime.now().toIso8601String(),
        'roomId': id,
        'membersPhoneNumber': membersPhoneNumber
      }
    );
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
    Map response = await networkManager.sendPostJSONRequestWithLogin(
        uri: 'send-messages-received-info',
        body: {
          'receivedTime': DateTime.now().toIso8601String(),
          'roomId': id,
          'messageOwnerPhoneNumber': lastMessage.from,
          'messageReceiverPhoneNumber': userPhoneNumber
        }
    );
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