import 'package:flutter/cupertino.dart';

class UnFocusTextFieldWidget extends StatelessWidget {
  UnFocusTextFieldWidget({this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
