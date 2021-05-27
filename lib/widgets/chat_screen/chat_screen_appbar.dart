import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class ChatScreenAppBar extends StatelessWidget {
  const ChatScreenAppBar({Key key}) : super(key: key);

  final double _appbarActionsWidth = 40;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Constant.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade900,
            offset: Offset(0, 1),
            blurRadius: 0.3,
            spreadRadius: 0.3,
          ),
        ],
      ),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 80,
                height: 60,
                child: Row(
                  children: [
                    SizedBox(width: 5,),
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5,),
                    CircleAvatar(
                      radius: 20,
                      child: ClipOval(
                        child: Image.asset('assets/images/avatar.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4,),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8,),
                    Text(
                      'Canay Bozkuş',
                      style: TextStyle(
                          fontSize: Constant.defaultFontSize,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2,),
                    Text(
                      'online',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: _appbarActionsWidth,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.videocam),
                color: Colors.white,
                splashRadius: 20,
                padding: EdgeInsets.zero,
                onPressed: (){},
              ),
            ),
          ),
          SizedBox(
            width: _appbarActionsWidth,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.phone),
                color: Colors.white,
                splashRadius: 20,
                padding: EdgeInsets.zero,
                onPressed: (){},
              ),
            ),
          ),
          SizedBox(
            width: _appbarActionsWidth,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.more_vert),
                color: Colors.white,
                splashRadius: 20,
                padding: EdgeInsets.zero,
                onPressed: (){},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
