import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/widgets/main_screen/recent_call_card.dart';

class RecentCalls extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        RecentCallCard(),
        RecentCallCard(isVideoCall: true,),
      ],
    );
  }
}
