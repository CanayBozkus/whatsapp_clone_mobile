import 'package:firebase_messaging/firebase_messaging.dart';

class FCM {
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String _token;
  
  init() async {
    _token = await _messaging.getToken();
  }
  
  String get token => _token;
}

FCM fcmManager = FCM();