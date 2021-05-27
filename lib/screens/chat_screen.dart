import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_screen/chat_screen_appbar.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = 'ChatScreen';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constant.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              ChatScreenAppBar(),
              SizedBox(height: 50,),
            ],
          ),
        ),
      )
    );
  }
}
