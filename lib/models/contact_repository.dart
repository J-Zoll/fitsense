import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import './contact.dart';

class ContactRepository {
  // File name of the json file in which the contacts are stored
  static const String fileName = "contacts.json";

  static Future<List<Contact>> load() async {
    String path = await getApplicationDocumentsDirectory().then((dir) => dir.path);
    File file = File('$path/$fileName');
    if (await file.exists()) {
      String contactListJson = await file.readAsString(encoding: utf8);
      Iterable list = jsonDecode(contactListJson);
      List<Contact> contactList = List<Contact>.from(
          list.map((e) => Contact.fromJson(e)));
      return contactList;
    }
    return [];
  }

  /// Saves a List of Contacts as json file in the applications document
  /// directory.
  static Future<void> saveList(List<Contact> contactList) async {
    String contactListJson = jsonEncode(contactList);
    String path = await getApplicationDocumentsDirectory().then((dir) => dir.path);
    File file = File('$path/$fileName');
    file.writeAsString(contactListJson);
  }

  static Future<void> save(Contact contact) async {
    List<Contact> contactList = await ContactRepository.load();
    contactList.add(contact);
    await saveList(contactList);
  }


  static Future<void> delete(Contact contact) async {
    List<Contact> contactList = await ContactRepository.load();
    contactList.remove(contact);
    await saveList(contactList);
  }
}