import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/chatRoom.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/message.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/user.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/utilities/general_provider.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_screen/chat_screen_appbar.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_screen/chat_screen_text_field.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_screen/message_bubble.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = 'ChatScreen';

  ChatScreen({@required this.room});

  final ChatRoom room;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Message message = Message();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<GeneralProvider>().openAndCloseChatRoomHandler(widget.room);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    User user = context.read<GeneralProvider>().user;
    ChatRoom room = context.watch<GeneralProvider>().chatRooms.firstWhere((element) => element == widget.room);
    return Container(
      color: Constant.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                ChatScreenAppBar(contact: room.contact,),
                Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    children: [
                      ...room.messages.map((Message message){
                        return MessageBubble(
                          isMe: user.phoneNumber == message.from,
                          message: message,
                        );
                      }).toList(),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ChatScreenTextInput(
                          onSaved: (String value){
                            message.message = value;
                          },
                        )
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
                            onPressed: () async {
                              _formKey.currentState.save();
                              if(message.message.isEmpty){
                                return;
                              }
                              _formKey.currentState.reset();
                              await context.read<GeneralProvider>().sendMessage(widget.room, message);
                              message = Message();
                            },
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
        ),
      )
    );
  }
}
