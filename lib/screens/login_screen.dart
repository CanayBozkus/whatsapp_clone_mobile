import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/user.dart';
import 'package:whatsapp_clone_mobile/screens/main_screen.dart';
import 'package:whatsapp_clone_mobile/screens/registration_screen.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/utilities/general_provider.dart';
import 'package:whatsapp_clone_mobile/widgets/button/base_button.dart';
import 'package:whatsapp_clone_mobile/widgets/form/base_textformfield.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone_mobile/extensions/string.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'LoginScreen';

  final _formKey = GlobalKey<FormState>();
  final _user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Constant.defaultScreenPadding,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseTextFormField(
                hintText: 'Phone Number',
                onSaved: (String value){
                  String cleanNumber = value.getCleanPhoneNumber();
                  _user.phoneNumber = cleanNumber.substring(cleanNumber.length - 10);
                },
                validator: (String value){
                  if(value.isEmpty){
                    return 'Please enter a phone number';
                  }
                  String cleanNumber = value.getCleanPhoneNumber();
                  if(cleanNumber.length < 10){
                    return 'Invalid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              BaseButton(
                text: 'Login',
                onPressed: () async {
                  if(!_formKey.currentState.validate()){
                    return null;
                  }

                  _formKey.currentState.save();
                  bool success = await context.read<GeneralProvider>().login(_user);

                  if(success){
                    return Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
                  }
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
      ),
    );
  }
}
