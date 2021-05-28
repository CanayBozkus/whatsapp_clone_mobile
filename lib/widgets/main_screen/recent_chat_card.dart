import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/screens/chat_screen.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/base_recent_activity_card.dart';

class RecentChatCard extends StatelessWidget {
  const RecentChatCard({this.showTime = true, this.isMuted});
  final bool showTime;
  final bool isMuted;

  double getTimeContainerWidth(){
    if(showTime && !isMuted) return 40;
    if(showTime && isMuted) return 60;
    return 75;
  }


  @override
  Widget build(BuildContext context) {
    return BaseRecentActivityCard(
      onTap: (){
        Navigator.pushNamed(context, ChatScreen.routeName);
      },
      onLongPress: (){},
      mainText: 'Canay Bozkuş',
      subText: 'naber? nasılsın',
      rightContainerWidth: getTimeContainerWidth(),
      rightContainerChild: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 16,),
          Text(
            showTime ? '17:01' : '01:01:2000',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 14
            ),
          ),
          SizedBox(height: 10,),
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
    );
  }
}

