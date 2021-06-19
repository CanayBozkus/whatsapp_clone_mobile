import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone_mobile/models/hive_models/hive_user.dart';
import 'package:whatsapp_clone_mobile/services/fcm.dart';
import 'package:whatsapp_clone_mobile/services/file_manager.dart';
import 'package:whatsapp_clone_mobile/services/local_database_manager.dart';
import 'package:whatsapp_clone_mobile/services/network/multipart_data.dart';
import 'package:whatsapp_clone_mobile/services/network/network_manager.dart';
import 'package:whatsapp_clone_mobile/services/sharedPreferences.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class User {
  String name;
  String phoneNumber;
  String id;
  List contacts = [];
  File profilePicture;
  ShowLastSeenTypes showLastSeen = ShowLastSeenTypes.everyone;
  String about = 'Hey there, I am new on WhatsApp.';
  bool haveProfilePicture = false;

  Future<bool> register() async {
    MultipartData data = MultipartData();
    Map fields = {
      'name': name,
      'phoneNumber': phoneNumber,
      'haveProfilePicture': haveProfilePicture.toString(),
      "fcmToken": fcmManager.token,
    };

    data.addFieldsWithMap(fields);

    data.addFile(
      key: 'profilePicture',
      file: profilePicture,
      type: MultipartFileTypes.image,
      subtype: MultipartFileSubTypes.jpg,
    );

    Map response = await networkManager.sendPostMultipartRequestWithoutLogin(multipartData: data, uri: 'create-user');

    if(response['success']){
      id = response['id'];

      await this.saveUser();

      SharedPreferences pref = await getPreference();

      await pref.setString('jwt', response['token']);

      return true;
    }

    return false;
  }

  Future<void> saveUser({bool saveImage = true}) async {
    if (saveImage && this.haveProfilePicture) {
      String profilePictureName = phoneNumber.toString() + '_profile_picture';
      await fileManager.saveImage(profilePicture, profilePictureName);
    }

    localDatabaseManager.saveUser(this);
  }

  Future<void> getData(Directory path) async {
    HiveUser hiveUser = localDatabaseManager.getUser();

    this.name = hiveUser.name;
    this.phoneNumber = hiveUser.phoneNumber;
    this.contacts = hiveUser.contacts;
    this.id = hiveUser.id;
    this.showLastSeen = Constant.showLastSeenIndexesReverse[hiveUser.showLastSeen];
    this.about = hiveUser.about ?? this.about;
    this.haveProfilePicture = hiveUser.haveProfilePicture;

    if(haveProfilePicture){
      String imageName = '${phoneNumber}_profile_picture';
      this.profilePicture = fileManager.readImage(imageName);
    }
  }

  Future<bool> login(String path) async {
    Map res = await networkManager.sendPostJSONRequestWithoutLogin(
      uri: 'login',
      body: {
        "phoneNumber": phoneNumber,
        "fcmToken": fcmManager.token,
      }
    );

    if(res['success']){
      Map user = res['user'];
      haveProfilePicture = user['haveProfilePicture'];
      name = user['name'];
      about = user['about'];
      showLastSeen = Constant.showLastSeenIndexesReverse[user['showLastSeen']];
      id = user['id'];

      if(user['haveProfilePicture']){
        String imageName = '${this.phoneNumber}_profile_picture';
        this.profilePicture  = await fileManager.saveByteImage(user['profilePicture'], imageName);
      }

      await saveUser(saveImage: false);

      SharedPreferences pref = await getPreference();

      await pref.setString('jwt', res['token']);

      return true;
    }

    return false;
  }
}