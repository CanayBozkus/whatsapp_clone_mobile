import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_screen/chat_screen_appbar.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_screen/chat_screen_text_field.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_screen/message_bubble.dart';
import 'package:whatsapp_clone_mobile/widgets/form/base_textformfield.dart';

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
              Expanded(
                child: ListView(
                  reverse: true,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  children: [
                    MessageBubble(),
                    MessageBubble(isMe: false,)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ChatScreenTextInput()
                    ),
                    SizedBox(width: 5,),
                    ClipOval(
                      child: Material(
                        color: Constant.primaryColor,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 2
                          )
                        ),
                        child: IconButton(
                          icon: Icon(Icons.send, color: Colors.white,),
                          onPressed: (){},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
            ],
          ),
        ),
      )
    );
  }
}
