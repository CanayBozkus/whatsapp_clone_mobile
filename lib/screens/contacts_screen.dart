import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/chatRoom.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/contact.dart';
import 'package:whatsapp_clone_mobile/screens/chat_screen.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/general/base_card.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone_mobile/utilities/general_provider.dart';

class ContactsScreen extends StatelessWidget {
  static const routeName = 'ContactsScreen';

  ContactsScreen({this.isCallScreen = false});

  final bool isCallScreen;

  @override
  Widget build(BuildContext context) {
    List<Contact> contacts = context.watch<GeneralProvider>().contacts;
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
          BaseCard(
            title: isCallScreen ?'New group call' : 'New group',
            showPrefixIcon: true,
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
            onTap: (){},
          ),
          BaseCard(
            title: 'New contact',
            showPrefixIcon: true,
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
            onTap: (){},
          ),

          ...contacts.map((Contact contact){
            return BaseCard(
              title: contact.name,
              subTitle: contact.about,
              avatarImage: contact.profilePicture,
              showAvatar: true,
              onTap: (){
                ChatRoom room = context.read<GeneralProvider>().getChatRoomFromContact(contact);
                Navigator.pushReplacementNamed(context, ChatScreen.routeName, arguments: room);
              },
              trailing: isCallScreen
                  ?
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.phone),
                    color: Constant.primaryColor,
                    iconSize: 28,
                    splashRadius: 22,
                    onPressed: (){},
                  ),
                  IconButton(
                    icon: Icon(Icons.videocam),
                    color: Constant.primaryColor,
                    iconSize: 28,
                    splashRadius: 22,
                    onPressed: (){},
                  ),
                ],
              )
                  :
              SizedBox.shrink(),
            );
          }).toList(),

          BaseCard(
            title: 'Invite friends',
            showPrefixIcon: true,
            prefixIcon: Icon(
              Icons.share,
              color: Colors.white,
              size: 34,
            ),
            onTap: (){},
          ),
          BaseCard(
            title: 'Contacts help',
            showPrefixIcon: true,
            prefixIcon: Icon(
              Icons.help,
              color: Colors.white,
              size: 34,
            ),
            onTap: (){},
          ),

        ],
      ),
    );
  }
}
