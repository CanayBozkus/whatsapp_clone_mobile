class Message {
  String message;
  String roomId;
  DateTime sendTime = DateTime.now();
  String to;
  String from;
  bool isSeen = false;
  bool isSent = false;

  static Message getMessageFromSocketData(data){
    Message message = Message();
    message.roomId = data['roomId'];
    message.to = data['to'];
    message.from = data['from'];
    message.sendTime = DateTime.parse(data['sendTime']);
    message.message = data['message'];

    return message;
  }
}