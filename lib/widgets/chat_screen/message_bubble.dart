import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/message.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.isMe = true, this.message});
  final Message message;
  final bool isMe;
  final double _radius = 12;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(isMe ? 25 : 0, 5, isMe ? 0 : 25, 5),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
                color: Constant.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: isMe ? Radius.circular(_radius) : Radius.circular(0),
                  bottomLeft: Radius.circular(_radius),
                  bottomRight: Radius.circular(_radius),
                  topRight: isMe ? Radius.circular(0) : Radius.circular(_radius),
                ),
                border: Border.all(color: Colors.black, width: 2,)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.message,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isMe ? Row(
                      children: [
                        SizedBox(
                          width: 8,
                          child: Icon(
                            Icons.check,
                            color: Colors.blue,
                            size: 18,
                          ),
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ],
                    ) : SizedBox.shrink(),
                    SizedBox(width: 3,),
                    Text(
                      '${message.sendTime.hour}:${message.sendTime.minute}',
                      style: TextStyle(
                        color: Colors.white70
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
