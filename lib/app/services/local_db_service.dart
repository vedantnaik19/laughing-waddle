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
    List<Contact> contacts = [];
    for (int i = 0; i < _box.length; i++) {
      var c = await _box.get(i, defaultValue: null);
      if (c != null) {
        c = Contact.fromMap(c);
        contacts.add(c);
      }
    }
    return contacts;
  }
}
