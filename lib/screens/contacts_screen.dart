import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/contacts_screen/contact_screen_card.dart';

class ContactsScreen extends StatelessWidget {
  static const routeName = 'ContactsScreen';

  ContactsScreen({this.isCallScreen = false});

  final bool isCallScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              'Select contact',
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
              '108 contacts',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500),
            ),
          ],
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
                ['Invite a friend', 'Contacts', 'Refresh', 'Help',]
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
      body: ListView(
        children: [
          ContactScreenCard(
            mainText: isCallScreen ?'New group call' : 'New group',
            isCallCard: false,
            prefixIcon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constant.primaryColor
              ),
              child: Icon(
                Icons.supervisor_account,
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
          ContactScreenCard(
            mainText: 'New contact',
            isCallCard: false,
            prefixIcon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Constant.primaryColor
              ),
              child: Icon(
                Icons.person_add,
                color: Colors.white,
                size: 34,
              ),
            ),
          ),

          ContactScreenCard(
            mainText: 'Canay Bozkuş',
            subText: 'Nillius in verba',
            isCallCard: isCallScreen,
          ),
          ContactScreenCard(
            mainText: 'Canay Bozkuş',
            isCallCard: isCallScreen,
          ),

          ContactScreenCard(
            mainText: 'Invite friends',
            isCallCard: false,
            prefixIcon: Icon(
              Icons.share,
              color: Colors.white,
              size: 34,
            ),
          ),
          ContactScreenCard(
            mainText: 'Contacts help',
            isCallCard: false,
            prefixIcon: Icon(
              Icons.help,
              color: Colors.white,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }
}
