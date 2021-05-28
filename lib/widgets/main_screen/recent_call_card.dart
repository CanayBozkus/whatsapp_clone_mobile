import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/base_recent_activity_card.dart';

class RecentCallCard extends StatelessWidget {
  RecentCallCard({
    this.isVideoCall = false,
  });
  final bool isVideoCall;

  @override
  Widget build(BuildContext context) {
    return BaseRecentActivityCard(
      onTap: (){

      },
      onLongPress: (){},
      mainText: 'Canay Bozkuş',
      subText: 'May 2, 20:20',
      subTextPrefixIcon: Icons.call_made,
      rightContainerWidth: 50,
      rightContainerChild: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            splashRadius: 25,
            icon: Icon(
              isVideoCall ? Icons.videocam : Icons.call,
              color: Constant.lightPrimaryColor,
            ),
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}
