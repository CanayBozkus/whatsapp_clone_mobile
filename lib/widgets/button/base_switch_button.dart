import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class BaseSwitchButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 20,
      child: Switch(
        value: true,
        onChanged: (bool value){

        },
        activeTrackColor: Colors.white70,
        activeColor: Colors.deepPurple.shade700,
        inactiveThumbColor: Constant.secondaryColor,
        inactiveTrackColor: Colors.black,
      ),
    );
  }
}
