import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class AttachmentModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Constant.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                child: Material(
                  color: Colors.deepPurpleAccent,
                  shape: CircleBorder(),
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        Icons.insert_drive_file,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ClipOval(
                child: Material(
                  color: Colors.red,
                  shape: CircleBorder(),
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        Icons.camera_alt,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ClipOval(
                child: Material(
                  color: Colors.pinkAccent,
                  shape: CircleBorder(),
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        Icons.photo,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                child: Material(
                  color: Colors.orange,
                  shape: CircleBorder(),
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        Icons.headphones,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ClipOval(
                child: Material(
                  color: Colors.green,
                  shape: CircleBorder(),
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        Icons.location_on,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ClipOval(
                child: Material(
                  color: Colors.blue,
                  shape: CircleBorder(),
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        Icons.account_circle,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
