import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class BaseRecentActivityCard extends StatelessWidget {
  BaseRecentActivityCard({
    this.onTap,
    this.onLongPress,
    this.mainText,
    this.subText,
    this.rightContainerWidth,
    this.rightContainerChild,
    this.subTextPrefixIcon,
    this.subTextPrefixIconColor = Colors.white,
  });

  final Function onTap;
  final Function onLongPress;
  final String mainText;
  final String subText;
  final double rightContainerWidth;
  final Widget rightContainerChild;
  final IconData subTextPrefixIcon;
  final Color subTextPrefixIconColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 90,
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 30,
                child: ClipOval(
                  child: Image.asset('assets/images/avatar.png'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: Colors.white38,
                          width: 0.5,
                        )
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12,),
                    Text(
                      mainText,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Constant.defaultFontSize,
                          fontWeight: FontWeight.w500
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        subTextPrefixIcon != null
                            ? Icon(subTextPrefixIcon, color: subTextPrefixIconColor, size: 15,)
                            : SizedBox.shrink(),
                        subTextPrefixIcon != null
                            ? SizedBox(width: 5,)
                            : SizedBox.shrink(),
                        Text(
                          subText,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: rightContainerWidth,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: Colors.white38,
                      width: 0.5,
                    )
                ),
              ),
              child: rightContainerChild,
            ),
            SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}
