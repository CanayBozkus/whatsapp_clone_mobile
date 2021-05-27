import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/screens/main_screen.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/button/base_button.dart';
import 'package:whatsapp_clone_mobile/widgets/form/base_textformfield.dart';

class RegistrationScreen extends StatelessWidget {
  static const routeName = 'RegistrationScreen';

  const RegistrationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Constant.defaultScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 2
                  )
                ),
                child: GestureDetector(
                  onTap: (){},
                  child: CircleAvatar(
                    radius: 80,
                    child: ClipOval(
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Constant.primaryColor,
                          BlendMode.color,
                        ),
                        child: Image.asset('assets/images/avatar.png'),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              BaseTextFormField(
                hintText: 'Name',
              ),
              SizedBox(height: 20,),
              BaseTextFormField(
                hintText: 'Phone Number',
              ),
              SizedBox(height: 25,),
              BaseButton(
                text: 'Register',
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
