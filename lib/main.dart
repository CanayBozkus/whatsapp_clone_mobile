import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone_mobile/route_generator.dart';
import 'package:whatsapp_clone_mobile/screens/login_screen.dart';
import 'package:whatsapp_clone_mobile/services/local_database_manager.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone_mobile/utilities/general_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localDatabaseManager.init();
  await Permission.contacts.request();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        initialRoute: LoginScreen.routeName,
      ),
    );
  }
}

