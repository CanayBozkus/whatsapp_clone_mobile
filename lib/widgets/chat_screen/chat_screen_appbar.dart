import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/screens/chat_detail_screen.dart';
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
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 80,
                height: 60,
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
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
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ChatDetailScreen.routeName);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Canay Bozkuş',
                      style: TextStyle(
                          fontSize: Constant.defaultFontSize,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'online',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
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
                  onPressed: () {},
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
                  onPressed: () {},
                ),
              ),
            ),
            SizedBox(
              width: _appbarActionsWidth,
              height: _appbarActionsWidth,
              child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                  child: PopupMenuButton(
                    color: Constant.primaryColor,
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    onSelected: (value) async {
                      print(value);
                      if(value == 'More'){
                        String res = await showMenu(
                          context: context,
                          color: Constant.primaryColor,
                          position: RelativeRect.fromLTRB(1, 0, 0, 1),
                          items:
                            [
                              'Report',
                              'Block',
                              'Clear chat',
                              'Export chat',
                              'Add shortcut',
                            ].map((e){
                              return PopupMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: Constant.popupMenuTextStyle,
                                ),
                              );
                            }).toList(),
                        );
                        print(res);
                      }
                    },
                    itemBuilder: (context) {
                      final items = [
                        'Add to contacts',
                        'Media, links, and docs',
                        'Search',
                        'Mute notifications',
                        'Wallpaper',
                      ].map((e) {
                        return PopupMenuItem(
                          child: Text(
                            e,
                            style: Constant.popupMenuTextStyle,
                          ),
                          value: e,
                        );
                      }).toList();
                      items.add(
                        PopupMenuItem(
                          value: 'More',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'More',
                                style: Constant.popupMenuTextStyle,
                              ),
                              Icon(Icons.arrow_right, color: Colors.white,),
                            ],
                          ),
                        )
                      );
                      return items;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
