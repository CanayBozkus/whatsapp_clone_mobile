import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class ContactScreenCard extends StatelessWidget {
  ContactScreenCard({
    this.onTap,
    this.onLongPress,
    this.mainText,
    this.subText = '',
    this.isCallCard = false,
    this.prefixIcon,
  });

  final Function onTap;
  final Function onLongPress;
  final String mainText;
  final String subText;
  final bool isCallCard;
  final Widget prefixIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: 75,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 90,
              alignment: Alignment.center,
              child: prefixIcon == null
                  ?
              CircleAvatar(
                radius: 25,
                child: ClipOval(
                  child: Image.asset('assets/images/avatar.png'),
                ),
              )
                  :
              prefixIcon,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: subText.isNotEmpty ? 12 : 25,),
                    Text(
                      mainText,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10,),
                    subText.isNotEmpty ? Text(
                      subText,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ) : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            isCallCard ? Container(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.phone),
                    color: Constant.primaryColor,
                    iconSize: 28,
                    splashRadius: 22,
                    onPressed: (){},
                  ),
                  IconButton(
                    icon: Icon(Icons.videocam),
                    color: Constant.primaryColor,
                    iconSize: 28,
                    splashRadius: 22,
                    onPressed: (){},
                  ),
                ],
              ),
            ) : SizedBox.shrink(),
            SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}
