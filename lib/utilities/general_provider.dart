import 'package:flutter/foundation.dart';

class GeneralProvider with ChangeNotifier{
  int _mainScreenIndex = 1;
  bool mainScreenNavigatorClicked = false;

  int get mainScreenIndex => this._mainScreenIndex;
  set mainScreenIndex(int index){
    if(index >= 0 && index <4){
      this._mainScreenIndex = index;
      notifyListeners();
    }
  }

}