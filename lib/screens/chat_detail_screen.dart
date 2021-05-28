import 'package:flutter/material.dart';

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
                expandedHeight: 300,
                floating: false,
                pinned: true,
                actions: [
                  Icon(Icons.more_vert)
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
          body: Column(
            children: [
              Text('Tezt')
            ],
          ),
        ),
      ),
    );
  }
}
