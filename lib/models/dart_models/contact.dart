import 'dart:io';
import 'package:whatsapp_clone_mobile/models/hive_models/hive_contact.dart';
import 'package:whatsapp_clone_mobile/services/fcm.dart';
import 'package:whatsapp_clone_mobile/services/file_manager.dart';
import 'package:whatsapp_clone_mobile/services/local_database_manager.dart';
import 'package:whatsapp_clone_mobile/services/network_manager.dart';
import 'package:whatsapp_clone_mobile/utilities/constants.dart';

class Contact {
  String phoneNumber;
  String name;
  File profilePicture;
  String about;
  bool isInContactList;
  bool haveProfilePicture = false;
  bool isOnline = false;
  DateTime lastSeenTime;
  String statusChannel = '';
  
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
        contact.profilePicture = fileManager.readImage('${contact.phoneNumber}_profile_picture');
      }
      contacts.add(contact);
    });

    return contacts;
  }

  static Future<List> checkAndUpdateContactListFromCloud({List newContactsPhoneNumber, String jwt, List<String> removedContactsPhoneNumber}) async {
    Map postJson = {
      'newContactsPhoneNumber': newContactsPhoneNumber,
      'removedContactsPhoneNumber': removedContactsPhoneNumber,
    };

    Map response = await networkManager.sendPostJSONRequestWithLogin(body: postJson, uri: 'check-and-update-contact-list');

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

  static Future<Contact> getAndSaveUnlistedContactDataFromCloud({String phoneNumber, String path, String userPhoneNumber}) async {
    Map res = await networkManager.sendGetJSONRequestWithLogin(
      uri: 'get-unlisted-contact-data',
      query: {
        'phoneNumber': phoneNumber,
        'from': userPhoneNumber,
      }
    );

    if(!res['success']){
      print(res);
      return null;
    }

    Contact contact = Contact();
    contact.phoneNumber = phoneNumber;
    contact.name = phoneNumber;
    contact.about = res['about'];
    contact.isInContactList = false;
    contact.haveProfilePicture = res['haveProfilePicture'];

    if(contact.haveProfilePicture){
      String imageName = '${contact.phoneNumber}_profile_picture';
      contact.profilePicture = await fileManager.saveByteImage(res['profilePicture'], imageName);
    }

    contact.save();
    return contact;
  }

  Future<void> checkContactStatus({String userPhoneNumber, Function callback}) async {
    Map res = await networkManager.sendGetJSONRequestWithLogin(
        uri: 'check-contact-status',
        query: {
          'phoneNumber': phoneNumber,
          'userPhoneNumber': userPhoneNumber,
        }
    );

    this.isOnline = res['isOnline'];
    this.lastSeenTime = res['lastSeenTime'] != null ? DateTime.parse(res['lastSeenTime']) : null;
    if(callback != null){
      callback();
    }
  }
  
  void subscribeStatusChannel(){
    statusChannel = 'status-channel-$phoneNumber';
    fcmManager.subscribe(statusChannel);
  }

  void unsubscribeStatusChannel(){
    fcmManager.unsubscribe(statusChannel);
  }
}