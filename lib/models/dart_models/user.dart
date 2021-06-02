import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone_mobile/models/hive_models/hive_user.dart';
import 'package:whatsapp_clone_mobile/services/local_database_manager.dart';
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
    http.Response createResponseRaw = await http.post(
      Uri.http(Constant.serverURI, 'create-user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'phoneNumber': phoneNumber,
        'haveProfilePicture': haveProfilePicture,
        'profilePicture': haveProfilePicture ? profilePicture.readAsBytesSync() : null,
      })
    );

    Map createResponse = jsonDecode(createResponseRaw.body);

    if(createResponse['success']){
      id = createResponse['id'];

      await this.saveUser();

      SharedPreferences pref = await getPreference();

      await pref.setString('jwt', createResponse['token']);

      return true;
    }

    return false;
  }

  Future<void> saveUser() async {
    if (this.haveProfilePicture) {
      final Directory path = await getApplicationDocumentsDirectory();
      String profilePictureName = phoneNumber.toString() + '_profile_picture';
      await this.profilePicture.copy('${path.path}/$profilePictureName');
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
      this.profilePicture = File('${path.path}/${phoneNumber}_profile_picture');
    }
  }
}