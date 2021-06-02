import 'dart:convert';
import 'dart:io';

import 'package:whatsapp_clone_mobile/models/hive_models/hive_contact.dart';
import 'package:whatsapp_clone_mobile/services/local_database_manager.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class Contact {
  String phoneNumber;
  String name;
  File profilePicture;
  String about;
  bool isInContactList;
  bool haveProfilePicture = false;
  
  void save(){
    localDatabaseManager.saveContact(this);
  }

  static List<Contact> getSavedContacts(Directory path){
    List hiveContacts = localDatabaseManager.getSavedContacts();
    List<Contact> contacts = [];

    hiveContacts.forEach((hiveContact) {
      Contact contact = Contact();
      contact.name = hiveContact.name;
      contact.phoneNumber = hiveContact.phoneNumber;
      contact.about = hiveContact.about;
      contact.isInContactList = hiveContact.isInContactList;
      contact.haveProfilePicture = hiveContact.haveProfilePicture;

      if(contact.haveProfilePicture){
        contact.profilePicture = File('${path.path}/${contact.phoneNumber}_profile_picture');
      }
      contacts.add(contact);
    });

    return contacts;
  }

  static Future<List> checkAndUpdateContactListFromCloud({List newContactsPhoneNumber, String jwt, List<String> removedContactsPhoneNumber}) async {
    http.Response responseRaw = await http.post(
        Uri.http(Constant.serverURI, 'check-and-update-contact-list'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonEncode(<String, dynamic>{
          'newContactsPhoneNumber': newContactsPhoneNumber,
          'removedContactsPhoneNumber': removedContactsPhoneNumber,
        })
    );

    Map response = jsonDecode(responseRaw.body);
    if(response['success']){
      return response['registeredUsers'];
    }
    return [];
  }

  static bool checkIfContactNameChangedOrContactDeleted(List<Map> deviceContacts, List<Contact> contacts, List<String> removedContactsPhoneNumber){
    bool isChanged = false;
    List<Contact> toBeRemoved = [];
    contacts.forEach((Contact contact){
      Map deviceContact = deviceContacts.firstWhere(
            (element) => element['phoneNumber'] == contact.phoneNumber,
        orElse: () => null,
      );

      if(deviceContact == null){
        toBeRemoved.add(contact);
        isChanged = true;
        if(contact.haveProfilePicture){
          contact.profilePicture.delete();
        }
        removedContactsPhoneNumber.add(contact.phoneNumber);
      }
      else if(contact.name != deviceContact['name']){
        contact.name = deviceContact['name'];
        isChanged = true;
      }
    });

    toBeRemoved.forEach((contact) {
      contacts.remove(contact);
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