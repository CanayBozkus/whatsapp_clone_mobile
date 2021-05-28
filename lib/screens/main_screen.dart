import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/main_screen_navigator.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/recent_calls.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/recent_chats.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/recent_statuses.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone_mobile/utilities/general_provider.dart';
class MainScreen extends StatefulWidget {
  static const routeName = 'MainScreen';
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _currentPageIndex;
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
    _currentPageIndex = context.watch<GeneralProvider>().mainScreenIndex;
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
                color: Constant.primaryColor,
                position: RelativeRect.fromLTRB(100, 0, 0, 10),
                items:
                  ['New group', 'New broadcast', 'WhatsApp Web', 'Starred messages', 'Settings']
                      .map((e){
                        return PopupMenuItem(
                          child: Text(
                            e,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        );
                  }).toList(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          MainScreenNavigator(controller: _pageController,),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index){
                if(!context.read<GeneralProvider>().mainScreenNavigatorClicked){
                  context.read<GeneralProvider>().mainScreenIndex = index;
                }
              },
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
