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
    this.onChanged,
    this.onSaved,
    this.validator,
    this.keyboard = KeyboardTypes.text,
  });

  final String hintText;
  final double borderRadius;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final int minLine;
  final int maxLine;
  final Function onSaved;
  final Function onChanged;
  final Function validator;
  final KeyboardTypes keyboard;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      minLines: minLine,
      keyboardType: Constant.keyboards[keyboard],
      onChanged: onChanged != null ? onChanged : (String value){},
      onSaved: onSaved != null ? onSaved : (String value){},
      validator: validator != null ? validator : (String value) => null,
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
        fillColor: Constant.primaryColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: suffixIcon != null ? 0 : 15),
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
