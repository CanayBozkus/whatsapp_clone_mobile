import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/route_generator.dart';
import 'package:whatsapp_clone_mobile/screens/chat_detail_screen.dart';
import 'package:whatsapp_clone_mobile/screens/chat_screen.dart';
import 'package:whatsapp_clone_mobile/screens/login_screen.dart';
import 'package:whatsapp_clone_mobile/screens/main_screen.dart';
import 'package:whatsapp_clone_mobile/screens/registration_screen.dart';
import 'package:whatsapp_clone_mobile/widgets/general/unfocus_textfield_widget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    
    Widget wrapper(Widget widget){
      return UnFocusTextFieldWidget(
        child: widget,
      );
    }

    switch(settings.name){
      case LoginScreen.routeName: return MaterialPageRoute(builder: (_) => wrapper(LoginScreen()));
      case RegistrationScreen.routeName: return MaterialPageRoute(builder: (_) => wrapper(RegistrationScreen()));
      case MainScreen.routeName: return MaterialPageRoute(builder: (_) => wrapper(MainScreen()));
      case ChatScreen.routeName: return MaterialPageRoute(builder: (_) => wrapper(ChatScreen()));
      case ChatDetailScreen.routeName: return MaterialPageRoute(builder: (_) => wrapper(ChatDetailScreen()));
      default: return MaterialPageRoute(builder: (_) => Text('error'));
    }
  }
}