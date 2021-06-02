import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/contact.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/user.dart';
import 'package:whatsapp_clone_mobile/models/hive_models/hive_device.dart';
import 'package:whatsapp_clone_mobile/models/hive_models/hive_device.dart';
import 'package:whatsapp_clone_mobile/models/hive_models/hive_user.dart';
import 'package:whatsapp_clone_mobile/models/hive_models/hive_contact.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class LocalDatabaseManager {
  Box _userBox;
  Box _contactBox;
  Box _deviceBox;
  init() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    Hive.registerAdapter(HiveUserAdapter());
    Hive.registerAdapter(HiveContactAdapter());
    Hive.registerAdapter(HiveDeviceAdapter());
    _userBox = await Hive.openBox('User');
    _contactBox = await Hive.openBox('Contact');
    _deviceBox = await Hive.openBox('Device');
  }

  void saveUser(User user){
    HiveUser hiveUser = HiveUser();
    hiveUser.contacts = user.contacts;
    hiveUser.haveProfilePicture = user.haveProfilePicture;
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

  List getSavedContacts(){
    return _contactBox.values.toList();
  }

  HiveDevice getDeviceSettings(){
    HiveDevice device;
    if(_deviceBox.isEmpty){
      device = HiveDevice();
      _deviceBox.add(device);
      return device;
    }
    return _deviceBox.values.first;
  }

  Future<void> clearContactList() async{
    await _contactBox.clear();
  }

  void saveContact(Contact contact){
    HiveContact hiveContact = _contactBox.values.firstWhere(
            (e) => e.phoneNumber == contact.phoneNumber,
      orElse: () => null,
    );
    if(hiveContact == null){
      hiveContact = HiveContact();
      hiveContact.name = contact.name;
      hiveContact.phoneNumber = contact.phoneNumber;
      hiveContact.about = contact.about;
      hiveContact.isInContactList = true;
      hiveContact.haveProfilePicture = contact.haveProfilePicture;
      _contactBox.add(hiveContact);
      return;
    }

    int index = _contactBox.values.toList().indexOf(hiveContact);

    hiveContact.name = contact.name;
    hiveContact.phoneNumber = contact.phoneNumber;
    hiveContact.about = contact.about;
    hiveContact.isInContactList = true;
    hiveContact.haveProfilePicture = contact.haveProfilePicture;

    _contactBox.putAt(index, hiveContact);
  }
}

LocalDatabaseManager localDatabaseManager = LocalDatabaseManager();