import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  Directory _path;

  init() async {
    _path = await getApplicationDocumentsDirectory();
  }

  Future<void> saveImage(File file, String name) async {
    List splitted = name.split('.');
    if(splitted.last == 'jpg' || splitted.last == 'png' || splitted.last == 'jpeg'){
      name = splitted.getRange(0, splitted.length-2).join('');
    }

    await file.copy('${_path.path}/$name.jpg');
  }

  File readImage(String name){
    List splitted = name.split('.');
    if(splitted.last == 'jpg' || splitted.last == 'png' || splitted.last == 'jpeg'){
      name = splitted.getRange(0, splitted.length-2).join('');
    }

    File file = File('${_path.path}/$name.jpg');
    return file;
  }

  Future<File> saveByteImage(List imageByteList, String name) async {
    List splitted = name.split('.');
    if(splitted.last == 'jpg' || splitted.last == 'png' || splitted.last == 'jpeg'){
      name = splitted.getRange(0, splitted.length-2).join('');
    }

    List<int> pictureBytes = List<int>.from(imageByteList);
    File picture = await File('${_path.path}/$name.jpg').writeAsBytes(pictureBytes);
    return picture;
  }
}

FileManager fileManager = FileManager();