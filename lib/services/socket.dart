import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_mobile/services/network/network_manager.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class SocketIO {
  SocketIO({@required this.jwt}){
    _socket = IO.io(
      'http://${Constant.serverURI}',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({'Authorization': 'Bearer $jwt'})
          .build(),
    );
  }

  String jwt;
  IO.Socket _socket;

  connect(Function onConnectHandler){
    this._socket.onConnect((_) async {
      print('connected ${this._socket.connected} ${this._socket.id}');
    });
    this._socket.onDisconnect((data) => print('disconnected'));
    this._socket.connect();
  }

  disconnect() async {
    networkManager.sendPostJSONRequestWithLogin(
      uri: 'disconnect',
    );
    this._socket.disconnect();
  }

  setChannelHandler(String channel, Function function){
    _socket.on(channel, function);
  }
}