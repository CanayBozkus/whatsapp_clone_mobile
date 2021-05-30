import 'package:flutter/material.dart';

class Constant{

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

