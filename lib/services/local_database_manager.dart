import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/user.dart';
import 'package:whatsapp_clone_mobile/models/hive_models/hive_user.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class LocalDatabaseManager {
  Box _userBox;
  init() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    Hive.registerAdapter(HiveUserAdapter());

    _userBox = await Hive.openBox('User');

  }

  void saveUser(User user){
    HiveUser hiveUser = HiveUser();
    hiveUser.contacts = user.contacts;
    hiveUser.profilePictureName = user.profilePictureName;
    hiveUser.phoneNumber = user.phoneNumber;
    hiveUser.name = user.name;
    hiveUser.id = user.id;
    hiveUser.showLastSeen = Constant.showLastSeenIndexes[user.showLastSeen];
    hiveUser.about = user.about;

    _userBox.add(hiveUser);
  }

  HiveUser getUser(){
    return _userBox.values.first;
  }
}

LocalDatabaseManager localDatabaseManager = LocalDatabaseManager();