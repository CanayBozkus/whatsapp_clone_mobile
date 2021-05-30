import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/general/base_card.dart';
import 'package:whatsapp_clone_mobile/widgets/settings_screen/general_settings.dart';
import 'package:whatsapp_clone_mobile/widgets/settings_screen/profile_setting.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = 'SettingsScreen';

  SettingsScreen({
    @required this.body,
  });
  final SettingScreenBody body;

  Widget getBodyWidget(){
    switch(body){
      case SettingScreenBody.generalSettings: return GeneralSettings();
      case SettingScreenBody.profile: return ProfileSetting();
      default: return Text('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        title: Text(
          'Settings',
        ),
      ),
      body: getBodyWidget(),
    );
  }
}
