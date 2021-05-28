import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class BaseTextFormField extends StatelessWidget {
  BaseTextFormField({
    this.hintText = '',
    this.borderRadius = 6.0,
    this.prefixIcon,
    this.suffixIcon,
    this.minLine = 1,
    this.maxLine = 1,
  });

  final String hintText;
  final double borderRadius;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final int minLine;
  final int maxLine;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextFormField(
      maxLines: maxLine,
      minLines: minLine,
      style: TextStyle(
        color: Colors.white,
        letterSpacing: 0.75,
        fontSize: Constant.defaultFontSize,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white70,
          fontSize: Constant.defaultFontSize,
          letterSpacing: 0.75,
          fontStyle: FontStyle.italic,
        ),
        fillColor: theme.primaryColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: suffixIcon != Null ? 0 : 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
              width: 2
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
              color: Constant.lightPrimaryColor,
              width: 2
          ),
        ),
      ),
    );
  }
}
