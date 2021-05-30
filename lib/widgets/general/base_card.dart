import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class BaseCard extends StatelessWidget {
  BaseCard({
    this.title,
    this.subTitle = '',
    this.trailing,
    this.showAvatar = false,
    this.showPrefixIcon = false,
    this.prefixIcon,
    this.onTap,
    this.subTitlePrefixIcon,
    this.backgroundColor = Colors.transparent,
    this.activateHero = false,
    this.heroTag,
    this.reverseTitles = false,
  });
  final String title;
  final String subTitle;
  final Widget trailing;
  final bool showAvatar;
  final bool showPrefixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Icon subTitlePrefixIcon;
  final Color backgroundColor;
  final bool activateHero;
  final String heroTag;
  final bool reverseTitles;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: showAvatar || showPrefixIcon ? 85 : subTitle.isEmpty ? 55 : 70,
          padding: showAvatar || showPrefixIcon ? EdgeInsets.only(right: 20) : EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showAvatar || showPrefixIcon
                  ?
              Container(
                width: 90,
                alignment: Alignment.center,
                child: showAvatar
                    ?
                (
                    activateHero
                    ?
                Hero(
                  tag: heroTag,
                  child: CircleAvatar(
                    radius: 30,
                    child: ClipOval(
                      child: Image.asset('assets/images/avatar.png'),
                    ),
                  ),
                ) :
                CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: Image.asset('assets/images/avatar.png'),
                  ),
                )
                )
                    :
                showPrefixIcon
                    ?
                prefixIcon
                    :
                SizedBox.shrink(),
              )
                  :
              SizedBox.shrink(),

              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    verticalDirection: reverseTitles ? VerticalDirection.up : VerticalDirection.down,
                    children: [
                      showAvatar || showPrefixIcon
                          ? SizedBox(height: subTitle.isNotEmpty ? 15 : 30,)
                          : SizedBox(height: 15,),
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Constant.defaultFontSize,
                            fontWeight: FontWeight.w500
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subTitle.isNotEmpty ? SizedBox(height: 10,) : SizedBox.shrink(),
                      subTitle.isNotEmpty
                          ?
                      Row(
                        children: [
                          subTitlePrefixIcon != null ? subTitlePrefixIcon : SizedBox.shrink(),
                          subTitlePrefixIcon != null ? SizedBox(width: 5,) : SizedBox.shrink(),
                          Expanded(
                            child: Text(
                              subTitle,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                          :
                      SizedBox.shrink(),
                    ],
                  ),
                ),
              ),

              trailing != null ? trailing : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
