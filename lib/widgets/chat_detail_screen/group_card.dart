import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class GroupCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Constant.primaryColor,
      child: InkWell(
        onTap: (){},
        child: Container(
          height: 80,
          child: Row(
            children: [
              Container(
                width: 90,
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: Image.asset('assets/images/avatar.png'),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12,),
                    Text(
                      'Whatsapp group',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Constant.defaultFontSize,
                          fontWeight: FontWeight.w500
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'ali, ayşe, fatma,ali, ayşe, fatma,ali, ayşe, fatma',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
