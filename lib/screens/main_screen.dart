import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/main_screen_navigator.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/recent_calls.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/recent_chats.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/recent_statuses.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'MainScreen';
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
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
            onPressed: (){
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(100, 0, 0, 10),
                items: [
                  PopupMenuItem(
                    child: Text('1'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          MainScreenNavigator(),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                Container(
                  child: Text('camera'),
                ),
                RecentChats(),
                RecentStatuses(),
                RecentCalls(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
