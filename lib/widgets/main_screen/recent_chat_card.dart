import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class RecentChatCard extends StatelessWidget {
  const RecentChatCard({this.showTime = true, this.isMuted});
  final bool showTime;
  final bool isMuted;

  double getTimeContainerWidth(){
    if(showTime && !isMuted) return 50;
    if(showTime && isMuted) return 75;
    return 85;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white38,
                    width: 0.5,
                  )
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12,),
                  Text(
                    'Canay Bozkuş',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Constant.defaultFontSize,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Selam, naber?',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: getTimeContainerWidth(),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: Colors.white38,
                      width: 0.5,
                    )
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 16,),
                Text(
                  showTime ? '17:01' : '01:01:2000',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isMuted ? Icon(
                      Icons.volume_off,
                      color: Colors.white70,
                    ) : SizedBox.shrink(),
                    SizedBox(width: 5,),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Constant.lightPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '1',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
    );
  }
}
