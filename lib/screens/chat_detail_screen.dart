import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:whatsapp_clone_mobile/widgets/button/base_switch_button.dart';
import 'package:whatsapp_clone_mobile/widgets/chat_detail_screen/chat_detail_settings_container.dart';
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
