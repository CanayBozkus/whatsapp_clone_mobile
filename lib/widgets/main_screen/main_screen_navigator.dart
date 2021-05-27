import 'package:flutter/material.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class MainScreenNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _focusedPageIndex = 3;
    return Container(
      decoration: BoxDecoration(
        color: Constant.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade900,
            offset: Offset(0, 1),
            blurRadius: 0.3,
            spreadRadius: 0.3,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Icon(
                    Icons.photo_camera_rounded,
                    size: 26,
                    color: _focusedPageIndex == 0 ? Colors.white : Colors.white70,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){},
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: _focusedPageIndex == 1 ? Colors.white : Colors.transparent, width: 3)
                      )
                  ),
                  child: Text(
                    'CHATS',
                    style: _focusedPageIndex == 1
                        ? Constant.mainScreenNavigationFocusedTextStyle
                        : Constant.mainScreenNavigationUnFocusedTextStyle,
                  ),
                ),
              ),
            ),
          ),
          /*
          Expanded(
            flex: 2,
            child: TextButton(
              onPressed: (){},
              child: Text(
                'STATUS',
                style: Constant.mainScreenNavigationTextStyle,
              ),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  primary: Colors.white70
              ),
            ),
          ),*/
          Expanded(
            flex: 2,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){},
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: _focusedPageIndex == 2 ? Colors.white : Colors.transparent, width: 3)
                      )
                  ),
                  child: Text(
                    'STATUS',
                    style: _focusedPageIndex == 2
                        ? Constant.mainScreenNavigationFocusedTextStyle
                        : Constant.mainScreenNavigationUnFocusedTextStyle,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){},
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: _focusedPageIndex == 3 ? Colors.white : Colors.transparent, width: 3)
                      )
                  ),
                  child: Text(
                    'CALLS',
                    style: _focusedPageIndex == 3
                        ? Constant.mainScreenNavigationFocusedTextStyle
                        : Constant.mainScreenNavigationUnFocusedTextStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
