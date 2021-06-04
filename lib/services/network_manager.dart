import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class NetworkManager {
  String _jwt;

  init(String jwt){
    if(_jwt != null){
      return;
    }
    _jwt = jwt;
  }

  Future<Map> sendPostRequestWithoutLogin({Map body, String uri}) async {
    http.Response responseRaw = await http.post(
        Uri.http(Constant.serverURI, uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body)
    );
    Map response = jsonDecode(responseRaw.body);

    return response;
  }

  Future<Map> sendPostRequestWithLogin({Map body, String uri}) async {
    http.Response responseRaw = await http.post(
        Uri.http(Constant.serverURI, uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_jwt'
        },
        body: jsonEncode(body)
    );
    Map response = jsonDecode(responseRaw.body);

    return response;
  }

  Future<Map> sendGetRequestWithLogin({String uri, Map<String, dynamic> query}) async {
    http.Response responseRaw = await http.get(
        Uri.http(Constant.serverURI, uri, query),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_jwt'
        },
    );

    Map response = jsonDecode(responseRaw.body);

    return response;
  }

}

NetworkManager networkManager = NetworkManager();
