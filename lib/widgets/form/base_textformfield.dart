import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class BaseTextFormField extends StatelessWidget {
  BaseTextFormField({this.hintText = ''});

  final String hintText;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextFormField(
      style: TextStyle(
        color: Colors.white70,
        letterSpacing: 0.75,
        fontSize: Constant.defaultFontSize,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white70,
          fontSize: Constant.defaultFontSize,
          letterSpacing: 0.75,
          fontStyle: FontStyle.italic,
        ),
        fillColor: theme.primaryColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
              width: 2
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
              color: Constant.lightPrimaryColor,
              width: 2
          ),
        ),
      ),
    );
  }
}
