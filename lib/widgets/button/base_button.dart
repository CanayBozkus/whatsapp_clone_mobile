import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    this.text = '',
    this.onPressed,
  });

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            fontSize: Constant.defaultFontSize,
            color: Colors.white70
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Constant.lightPrimaryColor,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        side: BorderSide(color: Colors.black, width: 2),
      ),
    );
  }
}
