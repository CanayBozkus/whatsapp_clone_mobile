import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class ChatDetailSettingsContainer extends StatelessWidget {
  ChatDetailSettingsContainer({
    this.title,
    this.action
  });

  final String title;
  final Widget action;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constant.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: Constant.defaultFontSize
            ),
          ),
          action != null ? action : SizedBox.shrink(),
        ],
      ),
    );
  }
}
