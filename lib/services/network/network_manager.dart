import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_mobile/services/network/http_request_data.dart';
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

  Future<Map> _sendPostJSONRequestWithoutLogin({Map body, String uri}) async {
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

  Future<Map> _sendPostJSONRequestWithLogin({Map body, String uri}) async {
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

  Future<Map> _sendPostMultipartRequestWithoutLogin({String uri, HttpRequestData multipartData}) async {
    Uri parsedUri = Uri.http(Constant.serverURI, uri);
    http.MultipartRequest request = new http.MultipartRequest("POST", parsedUri);
    multipartData.addFieldsToMultipartRequest(request);

    try {
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      return jsonDecode(response.body);
    } catch (e) {
      return {};
    }
  }

  Future<Map> _sendPostMultipartRequestWithLogin({String uri, HttpRequestData multipartData}) async {
    Uri parsedUri = Uri.http(Constant.serverURI, uri);
    http.MultipartRequest request = new http.MultipartRequest("POST", parsedUri);
    await multipartData.addFieldsToMultipartRequest(request);

    request.headers['Authorization'] = 'Bearer $_jwt';
    try {
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false};
    }
  }

  Future<Map> sendPostRequest({String uri, HttpRequestData requestData, bool login = true}) async {
    requestData = requestData ?? HttpRequestData();
    if(requestData.hasFiles){
      if(login){
        return await _sendPostMultipartRequestWithLogin(uri: uri, multipartData: requestData);
      }
      return await _sendPostMultipartRequestWithoutLogin(uri: uri, multipartData: requestData);
    }

    if(login){
      return await _sendPostJSONRequestWithLogin(uri: uri, body: requestData.getJsonBody());
    }
    return await _sendPostJSONRequestWithoutLogin(uri: uri, body: requestData.getJsonBody());
  }
}

NetworkManager networkManager = NetworkManager();
