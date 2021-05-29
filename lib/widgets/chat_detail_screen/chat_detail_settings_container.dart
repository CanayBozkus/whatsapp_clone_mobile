import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class ChatDetailSettingsContainer extends StatelessWidget {
  ChatDetailSettingsContainer({
    this.title,
    this.action,
    this.onTap,
    this.titleFontColor = Colors.white,
    this.prefixIcon,
  });

  final String title;
  final Widget action;
  final Function onTap;
  final Color titleFontColor;
  final Icon prefixIcon;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Constant.primaryColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: prefixIcon != null ? 0 : 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              prefixIcon != null
                  ?
              Container(
                width: 90,
                child: prefixIcon,
              )
                  : SizedBox.shrink(),
              SizedBox.shrink(),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: titleFontColor,
                    fontSize: Constant.defaultFontSize,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              action != null ? action : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
