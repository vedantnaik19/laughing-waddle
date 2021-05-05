import 'package:contacts_service/contacts_service.dart';

import '../../app/core/constants/app_contants.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class LocalDbService extends GetxService {
  Box _box;
  @override
  void onInit() {
    _box = Hive.box(AppConstants.BOX_NAME);

    super.onInit();
  }

  Future<void> saveContacts(List<Contact> contacts) async {
    for (int i = 0; i < contacts.length; i++) {
      await _box.put(i, contacts[i].toMap());
    }
  }

  Future<void> deleteAllContacts() async {
    await _box.clear();
  }

  Future<List<Contact>> getAllContacts() async {
    // List<Contact> contacts = [];
    List<Contact> head = [];
    List<Contact> mid = [];
    List<Contact> tail = [];
    for (int i = 0; i < _box.length; i++) {
      var c = await _box.get(i, defaultValue: null);
      if (c != null) {
        var contact = Contact.fromMap(c);
        if ((contact.displayName ?? " ")
            .trim()
            .startsWith(RegExp(r'[a-zA-Z]'))) {
          head.add(contact);
        } else if ((contact.displayName ?? " ")
            .trim()
            .startsWith(RegExp(r'[0-9]'))) {
          mid.add(contact);
        } else
          tail.add(contact);
      }
    }

    return head + mid + tail;
  }
}
