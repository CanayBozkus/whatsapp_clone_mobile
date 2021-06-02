
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/contact.dart';
import 'package:whatsapp_clone_mobile/models/dart_models/user.dart';
import 'package:whatsapp_clone_mobile/models/hive_models/hive_device.dart';
import 'package:whatsapp_clone_mobile/services/contact_manager.dart';
import 'package:whatsapp_clone_mobile/services/local_database_manager.dart';
import 'package:whatsapp_clone_mobile/services/sharedPreferences.dart';
import 'package:whatsapp_clone_mobile/services/socket.dart';

class GeneralProvider with ChangeNotifier{
  int _mainScreenIndex = 1;
  bool mainScreenNavigatorClicked = false;
  SocketIO _socket;
  ContactManager _contactManager = ContactManager();
  String _jwt;
  User _user = User();
  List<Contact> _contacts;
  HiveDevice _deviceSettings;
  Directory _path;

  int get mainScreenIndex => this._mainScreenIndex;
  set mainScreenIndex(int index){
    if(index >= 0 && index <4){
      this._mainScreenIndex = index;
      notifyListeners();
    }
  }

  User get user => this._user;

  List<Contact> get contacts => this._contacts;

  Future<void> initialize() async {
    SharedPreferences pref = await getPreference();

    _jwt = pref.getString('jwt');

    _path = await getApplicationDocumentsDirectory();

    _deviceSettings = localDatabaseManager.getDeviceSettings();
    await _user.getData(_path);

    _contacts = Contact.getSavedContacts(_path);

    await refreshContactList();

    _socket = SocketIO(jwt: _jwt);
    _socket.connect((){});
  }

  Future<bool> register(User user) async {
    bool res = await user.register();
    return res;
  }

  Future<void> refreshContactList() async {
    //TODO: get profile image for new contact
    List<Map> deviceContacts = await _contactManager.getAllContacts();
    List<String> removedContactsPhoneNumber = [];
    bool isChanged = Contact.checkIfContactNameChangedOrContactDeleted(deviceContacts, _contacts, removedContactsPhoneNumber);

    List<Map> newDeviceContacts = Contact.checkNewContacts(deviceContacts, _contacts);
    List newDeviceContactsPhoneNumber = newDeviceContacts.map((e) => e['phoneNumber']).toList();

    if(isChanged){
      await localDatabaseManager.clearContactList();
      _contacts.forEach((Contact contact) {
        contact.save();
      });
    }

    if(newDeviceContacts.isEmpty){
      return;
    }

    List registeredUsers = await Contact.checkAndUpdateContactListFromCloud(jwt: _jwt, newContactsPhoneNumber: newDeviceContactsPhoneNumber, removedContactsPhoneNumber: removedContactsPhoneNumber);

    if(registeredUsers.isNotEmpty){
      for(var registeredUser in registeredUsers){
        Map deviceContact = newDeviceContacts.firstWhere((element) => element['phoneNumber'] == registeredUser['phoneNumber']);
        Contact contact = Contact();
        contact.name = deviceContact['name'];
        contact.phoneNumber = deviceContact['phoneNumber'];
        contact.about = registeredUser['about'];
        contact.isInContactList = true;
        contact.haveProfilePicture = registeredUser['haveProfilePicture'];

        if(contact.haveProfilePicture){
          List<int> pictureBytes = List<int>.from(registeredUser['profilePicture']);
          File picture = await File('${_path.path}/${contact.phoneNumber}_profile_picture').writeAsBytes(pictureBytes);
          contact.profilePicture = picture;
        }
        _contacts.add(contact);
        contact.save();
      }
    }

  }
}