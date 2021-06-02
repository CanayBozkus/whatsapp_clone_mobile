import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/chatRoom.dart';
import 'package:whatsapp_clone_mobile/utilities/general_provider.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/recent_chat_card.dart';
import 'package:provider/provider.dart';

class RecentChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ChatRoom> chatRooms = context.watch<GeneralProvider>().chatRooms;
    return ListView(
      children: [
        ...chatRooms.map((ChatRoom room){
          if(room.isSavedLocalDatabase) return RecentChatCard(room: room,);
          return SizedBox.shrink();
        }).toList(),
      ],
    );
  }
}
