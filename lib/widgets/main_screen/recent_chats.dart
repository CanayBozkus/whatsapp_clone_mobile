import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/recent_chat_card.dart';

class RecentChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        RecentChatCard(showTime: true, isMuted: true,),
        RecentChatCard(showTime: false, isMuted: true,),
        RecentChatCard(showTime: true, isMuted: false,),
        RecentChatCard(showTime: false, isMuted: false,),
      ],
    );
  }
}
