import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone_mobile/route_generator.dart';
import 'package:whatsapp_clone_mobile/screens/login_screen.dart';
import 'package:whatsapp_clone_mobile/screens/main_screen.dart';
import 'package:whatsapp_clone_mobile/services/file_manager.dart';
import 'package:whatsapp_clone_mobile/services/local_database_manager.dart';
import 'package:whatsapp_clone_mobile/services/sharedPreferences.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone_mobile/utilities/general_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localDatabaseManager.init();
  await Permission.contacts.request();
  await Firebase.initializeApp();
  await fileManager.init();
  SharedPreferences pref = await getPreference();
  runApp(MyApp(pref: pref,));
}

class MyApp extends StatelessWidget {

  MyApp({this.pref});
  final SharedPreferences pref;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeneralProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Constant.secondaryColor,
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: Constant.defaultFontSize,
              color: Colors.white70
            ),
          ),
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: pref.containsKey('jwt') ? MainScreen.routeName : LoginScreen.routeName,
      ),
    );
  }
}

