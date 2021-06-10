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

  backgroundListener(Function handler){
    FirebaseMessaging.onBackgroundMessage(handler);
  }
  
  foregroundListener(Function handler){
    FirebaseMessaging.onMessage.listen(handler);
  }

  subscribe(String topic){
    _messaging.subscribeToTopic(topic);
  }

  unsubscribe(String topic){
    _messaging.unsubscribeFromTopic(topic);
  }
}

Future<void> fcmMessageHandler (RemoteMessage event) async {
  print(event.data);
  notificationPlugin.showNotification(id: 0, title: 'message', body: "body", payload: "payload");
}

FCM fcmManager = FCM();