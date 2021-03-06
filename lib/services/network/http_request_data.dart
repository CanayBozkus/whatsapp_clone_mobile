import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class HttpRequestData {
  Map _fields = {};
  List _files = [];
  bool _hasFiles = false;

  Map _multipartFileTypesMap = {
    MultipartFileTypes.image: 'image',
  };
  Map _multipartFileSubTypesMap = {
    MultipartFileSubTypes.jpg: 'jpg'
  };

  bool get hasFiles => _hasFiles;

  void addField({@required String key, @required String field}){
    _fields[key] = field;
  }

  void addFieldsWithMap(Map map){
    map.keys.forEach((key) {
      _fields[key] = map[key];
    });
  }

  void addFile({@required String key, @required File file, @required MultipartFileTypes type, @required MultipartFileSubTypes subtype}){
    Map fileData = {};
    fileData['file'] = {key: file};
    fileData['type'] = _multipartFileTypesMap[type];
    fileData['subtype'] = _multipartFileSubTypesMap[subtype];

    _files.add(fileData);
  }

  Future<void> addFieldsToMultipartRequest(http.MultipartRequest request) async {
    if(_fields.isEmpty && _files.isEmpty){
      return;
    }

    _fields.keys.forEach((key) {
      request.fields[key] = _fields[key].toString();
    });

    for(Map fileData in _files){
      String key = fileData['file'].keys.first;
      request.files.add(
          await http.MultipartFile.fromPath(
              key,
              fileData['file'][key].path,
              contentType: MediaType(fileData['type'].toString(), fileData['subtype'].toString())
          )
      );
    }
  }

  Map getJsonBody(){
    return _fields;
  }
}

enum MultipartFileTypes {
  image
}

enum MultipartFileSubTypes {
  jpg
}