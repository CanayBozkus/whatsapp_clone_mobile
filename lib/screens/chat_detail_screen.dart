import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/button/base_switch_button.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_detail_screen/chat_detail_settings_container.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_detail_screen/group_card.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_detail_screen/recent_files_builder.dart';

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
                      background: Image.asset('assets/images/avatar.png', fit: BoxFit.cover,),
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
                    ChatDetailSettingsContainer(
                      action: BaseSwitchButton(),
                      title: 'Mute notifications',
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Divider(
                        color: Colors.white70,
                        height: 0,
                      ),
                    ),
                    ChatDetailSettingsContainer(
                      title: 'Custom notifications',
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Divider(
                        color: Colors.white70,
                        height: 0,
                      ),
                    ),
                    ChatDetailSettingsContainer(
                      title: 'Media visibility',
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      color: Constant.primaryColor,
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: Text(
                        'Phone Number',
                        style: TextStyle(
                          color: Colors.blue[100],
                          fontSize: 18
                        ),
                      ),
                    ),
                    ChatDetailSettingsContainer(
                      title: '555 653 85 37',
                      action: Material(
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
                            style: TextStyle(
                                color: Colors.blue[100],
                                fontSize: 18
                            ),
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
                    GroupCard(),
                    GroupCard(),
                    GroupCard(),
                    ChatDetailSettingsContainer(
                      title: '20 more',
                      prefixIcon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 30,
                      ),
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
