import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/general/base_card.dart';

class RecentCalls extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BaseCard(
          onTap: (){

          },
          showAvatar: true,
          title: 'Canay Bozkuş',
          subTitle: 'May 2, 20:20',
          subTitlePrefixIcon: Icon(
            Icons.call_made,
            color: Colors.white70,
            size: 15,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                splashRadius: 25,
                icon: Icon(
                  Icons.videocam,
                  color: Constant.lightPrimaryColor,
                ),
                onPressed: (){},
              ),
            ],
          ),
        ),
        BaseCard(
          onTap: (){

          },
          showAvatar: true,
          title: 'Canay Bozkuş',
          subTitle: 'May 2, 20:20',
          subTitlePrefixIcon: Icon(
            Icons.call_made,
            color: Colors.white70,
            size: 15,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                splashRadius: 25,
                icon: Icon(
                  Icons.call,
                  color: Constant.lightPrimaryColor,
                ),
                onPressed: (){},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
