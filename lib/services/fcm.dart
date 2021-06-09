import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:whatsapp_clone_mobile/services/notification_plugin.dart';

class FCM {
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String _token;
  
  init() async {
    _token = await _messaging.getToken();
    _messaging.requestPermission();
  }
  
  String get token => _token;

  backgroundListener(){

    FirebaseMessaging.onBackgroundMessage(handler);
  }
}

Future<void> handler (event) async {
  print(event);
  notificationPlugin.showNotification(id: 0, title: 'message', body: "body", payload: "payload");
}

FCM fcmManager = FCM();