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
  List contacts;
  String profilePictureName;
  File profilePicture;
  ShowLastSeenTypes showLastSeen = ShowLastSeenTypes.everyone;

  Future<bool> register() async {
    if(profilePicture != null){
      profilePictureName = phoneNumber.toString() + '_profile_picture' + '.' + profilePicture.path.split('.').last;
    }
    else {
      profilePictureName = 'avatar.png';
    }

    http.Response createResponseRaw = await http.post(
      Uri.http(Constant.serverURI, 'create-user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'phoneNumber': phoneNumber,
        'contacts': contacts,
        'profilePictureName': profilePictureName,
        'profilePicture': profilePicture != null ? profilePicture.readAsBytesSync() : null,
      })
    );

    Map createResponse = jsonDecode(createResponseRaw.body);

    if(createResponse['success']){
      id = createResponse['id'];
      contacts = createResponse['contacts'];

      await this.saveUser();

      SharedPreferences pref = await getPreference();

      await pref.setString('jwt', createResponse['token']);

      return true;
    }

    return false;
  }

  Future<void> saveUser() async {
    localDatabaseManager.saveUser(this);

    final Directory path = await getApplicationDocumentsDirectory();
    if (this.profilePicture != null) {
      await this.profilePicture.copy('${path.path}/$profilePictureName');
    }
  }

  Future<void> getData() async {
    final Directory path = await getApplicationDocumentsDirectory();
    HiveUser hiveUser = localDatabaseManager.getUser();

    this.name = hiveUser.name;
    this.phoneNumber = hiveUser.phoneNumber;
    this.profilePictureName = hiveUser.profilePictureName;
    this.contacts = hiveUser.contacts;
    this.id = hiveUser.id;
    this.showLastSeen = Constant.showLastSeenIndexesReverse[hiveUser.showLastSeen];

    this.profilePicture = File('${path.path}/$profilePictureName');
  }
}