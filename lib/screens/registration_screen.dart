import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/user.dart';
import 'package:whatsapp_clone_mobile/screens/main_screen.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/utilities/general_provider.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone_mobile/widgets/button/base_button.dart';
import 'package:whatsapp_clone_mobile/widgets/form/base_textformfield.dart';
import 'package:whatsapp_clone_mobile/extensions/string.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = 'RegistrationScreen';

  RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _user = User();
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Constant.defaultScreenPadding,
          child: Form(
            key: _formKey,
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
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.getImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        _user.profilePicture = File(pickedFile.path);
                        _user.haveProfilePicture = true;

                      } else {
                        print('No image selected.');
                      }
                      setState(() {});
                    },
                    child: CircleAvatar(
                      radius: 80,
                      child: ClipOval(
                        child: !_user.haveProfilePicture
                            ?
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Constant.primaryColor,
                            BlendMode.color,
                          ),
                          child: Image.asset('assets/images/avatar.png')
                        )
                            :
                        Image.file(_user.profilePicture),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                BaseTextFormField(
                  hintText: 'Name',
                  onSaved: (String value){
                    _user.name = value;
                  },
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                BaseTextFormField(
                  hintText: 'Phone Number',
                  keyboard: KeyboardTypes.phone,
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
                SizedBox(height: 25,),
                !_isRegistering
                    ?
                BaseButton(
                  text: 'Register',
                  onPressed: () async {
                    setState(() {
                      _isRegistering = true;
                    });
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      bool registerResponse = await context.read<GeneralProvider>().register(_user);
                      if(registerResponse){
                        Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
                      }
                    }
                    setState(() {
                      _isRegistering = false;
                    });
                  },
                )
                    :
                CircularProgressIndicator(
                  backgroundColor: Constant.primaryColor,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white60),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
