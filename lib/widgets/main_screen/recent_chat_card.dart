import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/chatRoom.dart';
import 'package:whatsapp_clone_mobile/screens/chat_screen.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/general/base_card.dart';

class RecentChatCard extends StatelessWidget {
  const RecentChatCard({this.room});
  final bool showTime = true;
  final bool isMuted = true;

  final ChatRoom room;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseCard(
          onTap: (){
            Navigator.pushNamed(context, ChatScreen.routeName, arguments: room);
          },
          title: room.contact.name,
          subTitle: room.lastMessage.message,
          avatarImage: room.contact.profilePicture,
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                showTime ? '17:01' : '01:01:2000',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14
                ),
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  room.isMuted ? Icon(
                    Icons.volume_off,
                    color: Colors.white70,
                  ) : SizedBox.shrink(),
                  SizedBox(width: 5,),
                  room.unReadMessageCount != 0
                      ?
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Constant.lightPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      room.unReadMessageCount.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  )
                      :
                  SizedBox.shrink()
                  ,
                  SizedBox(width: 5,),
                ],
              ),
            ],
          ),
          showAvatar: true,
        ),
        Padding(
          padding: EdgeInsets.only(left: 90.0),
          child: Divider(color: Colors.white30,height: 1,),
        )
      ],
    );
  }
}

