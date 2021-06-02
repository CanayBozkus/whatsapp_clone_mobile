import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/widgets/form/base_textformfield.dart';

class ChatScreenTextInput extends StatelessWidget {
  ChatScreenTextInput({this.onSaved});

  final Function onSaved;
  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
      onSaved: onSaved,
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
    );
  }
}
