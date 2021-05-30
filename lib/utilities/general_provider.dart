
import 'package:flutter/foundation.dart';
import 'package:whatsapp_clone_mobile/services/socket.dart';

class GeneralProvider with ChangeNotifier{
  int _mainScreenIndex = 1;
  bool mainScreenNavigatorClicked = false;
  SocketIO _socket;

  int get mainScreenIndex => this._mainScreenIndex;
  set mainScreenIndex(int index){
    if(index >= 0 && index <4){
      this._mainScreenIndex = index;
      notifyListeners();
    }
  }

  Future<void> initialize() async {
    _socket = SocketIO();
    _socket.connect((){});
  }

}