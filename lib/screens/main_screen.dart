import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:whatsapp_clone_mobile/screens/contacts_screen.dart';
import 'package:whatsapp_clone_mobile/screens/settings_screen.dart';
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

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  PageController _pageController;
  int _currentPageIndex;

  IconData getFloatingActionButtonIcon(){
    switch(_currentPageIndex){
      case 0: return Icons.camera_alt;
      case 1: return Icons.messenger;
      case 2: return Icons.camera_alt;
      case 3: return Icons.phone;
      default: return Icons.close;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _pageController = PageController(
      initialPage: 1,
    );
    context.read<GeneralProvider>().initialize();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.paused){
      Provider.of<GeneralProvider>(context, listen: false).closingAppHandler();
    }

    else if(state == AppLifecycleState.resumed){
      Provider.of<GeneralProvider>(context, listen: false).resumingAppHandler();
    }
    super.didChangeAppLifecycleState(state);
  }
  
  @override
  Widget build(BuildContext context) {
    _currentPageIndex = context.watch<GeneralProvider>().mainScreenIndex;
    return Scaffold(
      floatingActionButton: _currentPageIndex != 0
          ?
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _currentPageIndex == 2
              ?
          FloatingActionButton(
            mini: true,
            backgroundColor: Constant.primaryColor,
            child: Icon(
              Icons.create,
              size: 22,
            ),
            onPressed: (){},
          )
              :
          SizedBox.shrink(),
          SizedBox(height: 10,),
          FloatingActionButton(
            backgroundColor: Constant.primaryColor,
            child: Icon(getFloatingActionButtonIcon()),
            onPressed: (){
              if(_currentPageIndex == 1){
                Navigator.pushNamed(context, ContactsScreen.routeName, arguments: false);
              }
              else if(_currentPageIndex == 2){

              }
              else if(_currentPageIndex == 3){
                Navigator.pushNamed(context, ContactsScreen.routeName, arguments: true);
              }
            },
          ),
        ],
      )
          : SizedBox.shrink(),
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
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width: 40,
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
                    onSelected: (MainScreenDropdown dropdown) async {
                      switch(dropdown){
                        case MainScreenDropdown.settings: return Navigator.pushNamed(context, SettingsScreen.routeName, arguments: SettingScreenBody.generalSettings);
                        default: return null;
                      }
                    },
                    itemBuilder: (context) {
                      return MainScreenDropdown.values.map((dropdownValue) {
                        return PopupMenuItem(
                          child: Text(
                            Constant.mainScreenDropdownNames[dropdownValue],
                            style: Constant.popupMenuTextStyle,
                          ),
                          value: dropdownValue,
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
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
