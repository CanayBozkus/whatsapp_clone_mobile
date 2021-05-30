import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/screens/settings_screen.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/general/base_card.dart';

class GeneralSettings extends StatelessWidget {
  const GeneralSettings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 5),
      children: [
        BaseCard(
          showAvatar: true,
          title: 'Canay Bozkuş',
          subTitle: 'Nullius in Verba',
          activateHero: true,
          heroTag: 'profile_image',
          onTap: (){
            Navigator.pushNamed(context, SettingsScreen.routeName, arguments: SettingScreenBody.profile);
          },
        ),
        Divider(
          color: Colors.white,
          height: 0,
        ),
        BaseCard(
          title: 'Account',
          subTitle: 'Privacy, security, change number',
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.vpn_key_sharp,
            size: 40,
            color: Colors.white,
          ),
        ),
        BaseCard(
          title: 'Chats',
          subTitle: 'Theme, wallpapers, chat history',
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.chat,
            size: 40,
            color: Colors.white,
          ),
        ),
        BaseCard(
          title: 'Notifications',
          subTitle: 'Message, group & call tones',
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.notifications,
            size: 40,
            color: Colors.white,
          ),
        ),
        BaseCard(
          title: 'Storage and data',
          subTitle: 'Network usage, auto-download',
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.data_usage,
            size: 40,
            color: Colors.white,
          ),
        ),
        BaseCard(
          title: 'Help',
          subTitle: 'Help center, contact us, privacy policy',
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.help,
            size: 40,
            color: Colors.white,
          ),
        ),
        Divider(
          color: Colors.white,
          height: 0,
        ),
        BaseCard(
          title: 'Invite a friend',
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.supervisor_account,
            size: 40,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
