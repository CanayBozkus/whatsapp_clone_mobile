import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/general/base_card.dart';

class ProfileSetting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20),
      children: [
        GestureDetector(
          onTap: (){},
          child: Hero(
            tag: 'profile_image',
            child: CircleAvatar(
              radius: 80,
              child: ClipOval(
                child: Image.asset('assets/images/avatar.png'),
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        BaseCard(
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.account_circle,
            size: 40,
            color: Colors.white,
          ),
          title: 'Canay Bozkuş',
          subTitle: 'Name',
          reverseTitles: true,
          trailing: IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            iconSize: 30,
            splashRadius: 25,
            onPressed: (){},
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 90),
          child: Column(
            children: [
              Text(
                'This is not your username or pin. This name will be visible to your WhatsApp contacts',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16,),
              Divider(
                color: Colors.white,
                height: 0,
              ),
            ],
          ),
        ),
        BaseCard(
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.whatshot,
            size: 40,
            color: Colors.white,
          ),
          title: 'Nullius in Verba',
          subTitle: 'About',
          reverseTitles: true,
          trailing: IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            iconSize: 30,
            splashRadius: 25,
            onPressed: (){},
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 90),
          child: Divider(
            color: Colors.white,
            height: 0,
          ),
        ),
        BaseCard(
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.phone,
            size: 40,
            color: Colors.white,
          ),
          title: '555 653 85 37',
          subTitle: 'Phone',
          reverseTitles: true,
        ),
      ],
    );
  }
}
