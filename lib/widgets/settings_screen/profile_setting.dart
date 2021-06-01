import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/user.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/general/base_card.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone_mobile/utilities/general_provider.dart';

class ProfileSetting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    User user = context.watch<GeneralProvider>().user;
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
                child: user.profilePicture == null
                    ?
                Image.asset('assets/images/avatar.png')
                    :
                Image.file(user.profilePicture),
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
          title: user.name,
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
          title: user.about,
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
          title: user.phoneNumber,
          subTitle: 'Phone',
          reverseTitles: true,
        ),
      ],
    );
  }
}
