import 'package:whatsapp_clone_mobile/models/dart_models/contact.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/message.dart';
import 'package:whatsapp_clone_mobile/services/network_manager.dart';


class ChatRoom {
  String id;
  int unReadMessageCount = 0;
  Contact contact;
  Message lastMessage;
  bool isMuted = false;
  List<Message> messages = [];
  bool isSavedLocalDatabase = false;

  Future<bool> sendMessage(Message message) async {
    Map postJson = {
      'message': message.message,
      'roomId': message.roomId,
      'to': message.to,
      'sendTime': message.sendTime.toIso8601String(),
      'from': message.from
    };
    Map response = await networkManager.sendPostRequestWithLogin(body: postJson, uri: 'send-message');

    if(response['success']){
      message.isSent = true;
    }

    return response['success'];
  }

  void save(){
    this.isSavedLocalDatabase = true;
  }

  Future<void> sendMessageSeenInfo() async {

  }
}