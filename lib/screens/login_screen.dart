import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/screens/main_screen.dart';
import 'package:whatsapp_clone_mobile/screens/registration_screen.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/button/base_button.dart';
import 'package:whatsapp_clone_mobile/widgets/form/base_textformfield.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Constant.defaultScreenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseTextFormField(hintText: 'Phone Number',),
            SizedBox(height: 20,),
            BaseButton(
              text: 'Login',
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
              },
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, RegistrationScreen.routeName);
              },
              child: Text(
                'Don\'t have an account? Create now!',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
