import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class MainScreen extends StatelessWidget {
  static const routeName = 'MainScreen';
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        elevation: 0,
        title: Text(
          'WhatsApp',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            splashRadius: 20,
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            splashRadius: 20,
            onPressed: (){},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Constant.primaryColor,
            child: Row(
              children: [
                Icon(
                  Icons.photo_camera_rounded,
                ),
                Text(
                  'CHATS',
                ),
                Text(
                  'STATUS',
                ),
                Text(
                  'CALLS'
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
