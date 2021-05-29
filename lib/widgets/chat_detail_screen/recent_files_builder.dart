import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class RecentFilesBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Constant.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              offset: Offset(0, 0),
              blurRadius: 0.7,
              spreadRadius: 1,
            ),
          ]
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Media, links, and docs',
                  style: TextStyle(
                    color: Colors.blue[100],
                    fontSize: 18,
                  ),
                ),
                Text(
                  '20 >',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 15),
              children: [
                ...List<int>.generate(10, (i) => i + 1).map((e){
                  return Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Container(
                      width: 70,
                      color: Colors.black,
                      child: Text('1'),
                    ),
                  );
                }).toList()

              ],
            ),
          ),
        ],
      ),
    );
  }
}
