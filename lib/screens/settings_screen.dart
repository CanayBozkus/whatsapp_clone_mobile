import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = 'SettingsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        title: Text(
          'Settings',
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 80,
            child: Row(
              children: [
                Container(
                  width: 90,
                  child: Icon(
                    Icons.vpn_key_sharp,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account'
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.vpn_key_sharp,
              size: 35,
              color: Colors.white,
            ),
            title: Divider(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
