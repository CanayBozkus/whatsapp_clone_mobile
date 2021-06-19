import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/form/base_textformfield.dart';

class ChatScreenTextInput extends StatelessWidget {
  ChatScreenTextInput({this.onSaved, this.onPressAttachIcon});
  final Function onSaved;
  final Function onPressAttachIcon;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BaseTextFormField(
          onSaved: onSaved,
          maxLine: 3,
          borderRadius: 20,
          hintText: 'Type a message',
          prefixIcon: SizedBox(width: 1,),
          suffixIcon: SizedBox(width: 1,)
        ),
        Material(
          color: Colors.transparent,
          child: IconButton(
            splashRadius: 20,
            icon: Icon(
              Icons.tag_faces,
              color: Colors.white,
            ),
            onPressed: (){
            },
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
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
                      onPressed: onPressAttachIcon
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
      ],
    );
  }
}
