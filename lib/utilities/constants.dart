import 'package:flutter/material.dart';

class Constant{

  static const serverURI = '10.0.2.2:3000';

  static const Color primaryColor = Color(0xff4b005e);
  static const Color lightPrimaryColor = Color(0xff8932a8);
  static const Color secondaryColor = Color(0xff1b0333);
  static const alertColor = Color(0xffeb1a58);

  static const EdgeInsets defaultScreenPadding = EdgeInsets.symmetric(horizontal: 30);

  static const double defaultFontSize = 20.0;

  static const mainScreenNavigationUnFocusedTextStyle = TextStyle(
      color: Colors.white70,
      fontSize: 20,
      fontWeight: FontWeight.w600
  );
  static const mainScreenNavigationFocusedTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600
  );

  static const popupMenuTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
  static const subTitleTextStyle = TextStyle(
      color: Color(0xffbbdeef),
      fontSize: 18
  );

  static const mainScreenDropdownNames = {
    MainScreenDropdown.newBroadcast: 'New broadcast',
    MainScreenDropdown.newGroup: 'New group',
    MainScreenDropdown.whatsAppWeb: 'WhatsApp Web',
    MainScreenDropdown.starredMessages: 'Starred messages',
    MainScreenDropdown.settings: 'Settings',
  };

  static const keyboards = {
    KeyboardTypes.number: TextInputType.number,
    KeyboardTypes.text: TextInputType.text,
    KeyboardTypes.email: TextInputType.emailAddress,
    KeyboardTypes.phone: TextInputType.phone
  };

  static const showLastSeenIndexes = {
    ShowLastSeenTypes.everyone: 0,
    ShowLastSeenTypes.contacts: 1,
    ShowLastSeenTypes.nobody: 2
  };

  static const showLastSeenIndexesReverse = {
    0: ShowLastSeenTypes.everyone,
    1: ShowLastSeenTypes.contacts,
    2: ShowLastSeenTypes.nobody,
  };

  static const fcmTypesMatches = {
    "0": FCMTypes.message,
    "1": FCMTypes.messageSeen,
    '2': FCMTypes.messageReceived
  };
}

enum MainScreenDropdown {
  newGroup,
  newBroadcast,
  whatsAppWeb,
  starredMessages,
  settings
}

enum SettingScreenBody {
  generalSettings,
  profile,
}

enum KeyboardTypes {
  email,
  number,
  text,
  phone
}

enum ShowLastSeenTypes {
  everyone,
  nobody,
  contacts,
}

enum FCMTypes {
  message,
  messageSeen,
  messageReceived
}
