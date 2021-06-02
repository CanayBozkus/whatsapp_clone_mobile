class Message {
  String message;
  String roomId;
  DateTime sendTime = DateTime.now();
  String to;
  bool isSeen = false;
  bool isSent = false;
}