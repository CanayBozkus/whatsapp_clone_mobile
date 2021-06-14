import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_mobile/utilities/constants.dart';
import 'package:http_parser/http_parser.dart';

class NetworkManager {
  String _jwt;

  init(String jwt){
    if(_jwt != null){
      return;
    }
    _jwt = jwt;
  }

  Future<Map> sendPostJSONRequestWithoutLogin({Map body, String uri}) async {
    http.Response responseRaw = await http.post(
        Uri.http(Constant.serverURI, uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body ?? {})
    );
    Map response = jsonDecode(responseRaw.body);

    return response;
  }

  Future<Map> sendPostJSONRequestWithLogin({Map body, String uri}) async {
    http.Response responseRaw = await http.post(
        Uri.http(Constant.serverURI, uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_jwt'
        },
        body: jsonEncode(body ?? {})
    );
    Map response = jsonDecode(responseRaw.body);

    return response;
  }

  Future<Map> sendGetJSONRequestWithLogin({String uri, Map<String, dynamic> query}) async {
    http.Response responseRaw = await http.get(
        Uri.http(Constant.serverURI, uri, query ?? {}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_jwt'
        },
    );

    Map response = jsonDecode(responseRaw.body);

    return response;
  }

  Future<Map> sendPostMultipartRequestWithoutLogin({String uri, Map body}) async {
    Uri parsedUri = Uri.http(Constant.serverURI, uri);
    http.MultipartRequest request = new http.MultipartRequest("POST", parsedUri);

    if(body.keys.contains('fields')){
      for(var key in body['fields'].keys){
        request.fields[key] = body['fields'][key];
      }
    }

    if(body.keys.contains('files')){
      for(var file in body['files']){
        String key = file['file'].keys.first;
        request.files.add(
            await http.MultipartFile.fromPath(
              key,
              file['file'][key].path,
              contentType: MediaType(file['type'], file['subType'])
            )
        );
      }
    }
    try {
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      return jsonDecode(response.body);
    } catch (e) {
      return {};
    }
  }

}

NetworkManager networkManager = NetworkManager();
