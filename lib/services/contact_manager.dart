import 'package:contacts_service/contacts_service.dart';
import 'package:whatsapp_clone_mobile/extensions/string.dart';

class ContactManager {

  Future<List<String>> getAllContactPhoneNumber() async {
    Iterable<Contact> contactsRaw = await ContactsService.getContacts();

    return contactsRaw.toList().map((Contact contact){
       return contact
           .phones
           .firstWhere(
               (element) => element.label == 'mobile' || element.label == 'mobil')
           .value
           .getCleanPhoneNumber();
    }).toList();
  }

  Future<List<Map>> getAllContacts() async {
    Iterable<Contact> contactsRaw = await ContactsService.getContacts();

    return contactsRaw.toList().map((Contact contact){
      return {
        'name': contact.displayName,
        'phoneNumber': contact
            .phones
            .firstWhere(
                (element) => element.label == 'mobile' || element.label == 'mobil')
            .value
            .getCleanPhoneNumber(),
      };
    }).toList();
  }
}