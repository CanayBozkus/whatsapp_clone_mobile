import 'dart:io';

class Message {
  String message = '';
  String roomId;
  DateTime sendTime = DateTime.now();
  String from;
  bool isSeen = false;
  bool isSent = false;
  bool isReceived = false;
  List receivers = [];
  File file;
  String fileLocation;

  static Message getMessageFromSocketData(data){
    Message message = Message();
    message.roomId = data['roomId'];
    message.from = data['fromUser'];
    message.sendTime = DateTime.parse(data['sendTime']);
    message.message = data['message'];

    return message;
  }

  void save(){

  }
}