import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class SocketIO {
  IO.Socket _socket = IO.io(
    'http://${Constant.serverURI}',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({'Authorization': 'Bearer (token)'})
          .build(),
  );

  connect(Function onConnectHandler){
    this._socket.onConnect((_) async {
      print('connected ${this._socket.connected} ${this._socket.id}');
    });
    this._socket.onDisconnect((data) => print('disconnected'));
    this._socket.connect();
  }

  disconnect(phoneNumber, jwt) async {
    await http.post(
        Uri.http(Constant.serverURI, 'disconnect-socket'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonEncode(<String, String> {
          'phoneNumber': phoneNumber
        })
    );
    this._socket.disconnect();
  }
}