import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_screen/chat_screen_appbar.dart';
import 'package:whatsapp_clone_mobile/widgets/form/base_textformfield.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = 'ChatScreen';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constant.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              ChatScreenAppBar(),
              Expanded(
                child: ListView(
                  children: [],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: BaseTextFormField(
                        maxLine: 3,
                        borderRadius: 20,
                        hintText: 'Type a message',
                        prefixIcon: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            splashRadius: 20,
                            icon: Icon(
                              Icons.tag_faces,
                              color: Colors.white,
                            ),
                            onPressed: (){
                              print(1);
                            },
                          ),
                        ),
                        suffixIcon: Container(
                          width: 65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 30,
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    splashRadius: 15,
                                    iconSize: 20,
                                    icon: Icon(
                                      Icons.attach_file,
                                      color: Colors.white,
                                    ),
                                    onPressed: (){
                                      print(1);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    iconSize: 20,
                                    padding: EdgeInsets.zero,
                                    splashRadius: 15,
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    onPressed: (){
                                      print(1);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    ClipOval(
                      child: Material(
                        color: Constant.primaryColor,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 2
                          )
                        ),
                        child: IconButton(
                          icon: Icon(Icons.send, color: Colors.white,),
                          onPressed: (){},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
            ],
          ),
        ),
      )
    );
  }
}
