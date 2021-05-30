import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/screens/chat_screen.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/general/base_card.dart';

class RecentChatCard extends StatelessWidget {
  const RecentChatCard({this.showTime = true, this.isMuted});
  final bool showTime;
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseCard(
          onTap: (){
            Navigator.pushNamed(context, ChatScreen.routeName);
          },
          title: 'Canay Bozkuş',
          subTitle: 'naber? nasılsın naber? nasılsın naber? nasılsın',
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
                  isMuted ? Icon(
                    Icons.volume_off,
                    color: Colors.white70,
                  ) : SizedBox.shrink(),
                  SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Constant.lightPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                ],
              ),
            ],
          ),
          showAvatar: true,
        ),
        Padding(
          padding:  EdgeInsets.only(left: 90.0),
          child: Divider(color: Colors.white30,height: 1,),
        )
      ],
    );
  }
}

