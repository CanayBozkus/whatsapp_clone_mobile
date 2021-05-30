import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/button/base_switch_button.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_detail_screen/chat_detail_settings_container.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_detail_screen/group_card.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_detail_screen/recent_files_builder.dart';
import 'package:whatsapp_clone_mobile/widgets/general/base_card.dart';

class ChatDetailScreen extends StatelessWidget {
  static const routeName = 'ChatDetailScreen';

  const ChatDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView( 
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return [
              SliverAppBar(
                backgroundColor: Constant.primaryColor,
                expandedHeight: 300,
                floating: false,
                pinned: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 40,
                      child: ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          shape: CircleBorder(),
                          child: PopupMenuButton(
                            color: Constant.primaryColor,
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onSelected: (value) async {
                              print(value);
                            },
                            itemBuilder: (context) {
                              final items = [
                                'Add to contacts',
                                'Verify security code',
                              ].map((e) {
                                return PopupMenuItem(
                                  child: Text(
                                    e,
                                    style: Constant.popupMenuTextStyle,
                                  ),
                                  value: e,
                                );
                              }).toList();
                              return items;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints){
                    return FlexibleSpaceBar(
                      title: Container(
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Canay Bozkuş',
                              style: TextStyle(

                              ),
                            ),
                            Text(
                              '~ online',
                              style: TextStyle(
                                  fontSize: 14 - constraints.biggest.height/100
                              ),
                            ),
                          ],
                        ),
                      ),
                      titlePadding: EdgeInsets.symmetric(horizontal: 60 - constraints.biggest.height/10),
                      background: Hero(
                        tag: 'profile_image',
                        child: Image.asset('assets/images/avatar.png', fit: BoxFit.cover,),
                      ),
                    );
                  },
                ),
              )
            ];
          },
          body: ListView(
            padding: EdgeInsets.symmetric(vertical: 20),
            children: [
              RecentFilesBuilder(),
              SizedBox(height: 10,),
              Container(
                child: Column(
                  children: [
                    BaseCard(
                      title: 'Mute notifications',
                      trailing: BaseSwitchButton(),
                      backgroundColor: Constant.primaryColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Divider(
                        color: Colors.white70,
                        height: 0,
                      ),
                    ),
                    BaseCard(
                      title: 'Custom notifications',
                      backgroundColor: Constant.primaryColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Divider(
                        color: Colors.white70,
                        height: 0,
                      ),
                    ),
                    BaseCard(
                      title: 'Media visibility',
                      backgroundColor: Constant.primaryColor,
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      color: Constant.primaryColor,
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: Text(
                        'Phone Number',
                        style: Constant.subTitleTextStyle,
                      ),
                    ),
                    BaseCard(
                      title: '555 653 85 37',
                      trailing: Material(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.messenger,),
                              color: Colors.white70,
                              splashRadius: 20,
                              onPressed: (){},
                            ),
                            IconButton(
                              icon: Icon(Icons.phone),
                              color: Colors.white70,
                              splashRadius: 20,
                              onPressed: (){},
                            ),
                            IconButton(
                              icon: Icon(Icons.videocam),
                              color: Colors.white70,
                              splashRadius: 20,
                              onPressed: (){},
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: Constant.primaryColor,
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      color: Constant.primaryColor,
                      padding: EdgeInsets.only(top: 10, left: 20, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Groups in common',
                            style: Constant.subTitleTextStyle,
                          ),
                          Text(
                            '30',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18
                            ),
                          ),
                        ],
                      ),
                    ),
                    BaseCard(
                      showAvatar: true,
                      title: 'Whatsapp Group',
                      subTitle: 'ali, ayşe fatma',
                      backgroundColor: Constant.primaryColor,
                      onTap: (){},
                    ),
                    BaseCard(
                      showAvatar: true,
                      title: 'Whatsapp Group',
                      subTitle: 'ali, ayşe fatma',
                      backgroundColor: Constant.primaryColor,
                      onTap: (){},
                    ),
                    BaseCard(
                      showAvatar: true,
                      title: 'Whatsapp Group',
                      subTitle: 'ali, ayşe fatma',
                      backgroundColor: Constant.primaryColor,
                      onTap: (){},
                    ),
                    BaseCard(
                      showAvatar: true,
                      title: 'Whatsapp Group',
                      subTitle: 'ali, ayşe fatma',
                      backgroundColor: Constant.primaryColor,
                      onTap: (){},
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 90),
                      child: Divider(
                        color: Colors.white70,
                        height: 0,
                      ),
                    ),
                    BaseCard(
                      title: '20 more',
                      showPrefixIcon: true,
                      prefixIcon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 30,
                      ),
                      backgroundColor: Constant.primaryColor,
                    ),
                    SizedBox(height: 20,),
                    ChatDetailSettingsContainer(
                      title: 'Block',
                      titleFontColor: Constant.alertColor,
                      prefixIcon: Icon(
                        Icons.not_interested,
                        size: 30,
                        color: Constant.alertColor,
                      ),
                    ),
                    SizedBox(height: 20,),
                    ChatDetailSettingsContainer(
                      title: 'Report contact',
                      titleFontColor: Constant.alertColor,
                      prefixIcon: Icon(
                        Icons.thumb_down,
                        size: 30,
                        color: Constant.alertColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
