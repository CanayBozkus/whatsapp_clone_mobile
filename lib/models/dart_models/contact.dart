import 'dart:convert';
import 'dart:io';

import 'package:whatsapp_clone_mobile/models/hive_models/hive_contact.dart';
import 'package:whatsapp_clone_mobile/services/local_database_manager.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class Contact {
  String phoneNumber;
  String name;
  File profileImage;
  String about;
  bool isInContactList;

  void save(){
    localDatabaseManager.saveContact(this);
  }

  static List<Contact> getSavedContacts(){
    List hiveContacts = localDatabaseManager.getSavedContacts();
    List<Contact> contacts = [];

    hiveContacts.forEach((hiveContact) {
      Contact contact = Contact();
      contact.name = hiveContact.name;
      contact.phoneNumber = hiveContact.phoneNumber;
      contact.about = hiveContact.about;
      contact.isInContactList = hiveContact.isInContactList;
      contacts.add(contact);
    });

    return contacts;
  }

  static Future<List> checkIfNewContactsRegistered(List newContactsPhoneNumber, String jwt) async {
    http.Response responseRaw = await http.post(
        Uri.http(Constant.serverURI, 'check-if-new-contacts-registered'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonEncode(<String, dynamic>{
          'newContactsPhoneNumber': newContactsPhoneNumber,
        })
    );

    Map response = jsonDecode(responseRaw.body);
    print(response);
    if(response['success']){
      return response['registeredUsers'];
    }
    return [];
  }

  static bool checkIfContactNameChangedOrContactDeleted(List<Map> deviceContacts, List<Contact> contacts){
    bool isChanged = false;
    contacts.forEach((Contact contact){
      Map deviceContact = deviceContacts.firstWhere(
            (element) => element['phoneNumber'] == contact.phoneNumber,
        orElse: () => null,
      );

      if(deviceContact == null){
        contacts.remove(contact);
        isChanged = true;
      }
      else if(contact.name != deviceContact['name']){
        contact.name = deviceContact['name'];
        isChanged = true;
      }
    });

    return isChanged;
  }

  static List<Map> checkNewContacts(List<Map> deviceContacts, List<Contact> contacts){
    List<Map> newDeviceContacts = [];
    deviceContacts.forEach((Map deviceContact) {
      Contact existContact = contacts.firstWhere(
              (Contact contact) => contact.phoneNumber == deviceContact['phoneNumber'],
          orElse: () => null);
      if(existContact == null){
        newDeviceContacts.add(deviceContact);
      }
    });

    return newDeviceContacts;
  }
}