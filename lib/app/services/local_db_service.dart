import 'package:contacts/app/data/models/db_contact.dart';
import 'package:contacts/app/utils/db_helper.dart';
import 'package:contacts/app/utils/helper.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';

class LocalDbService extends GetxService {
  final dbHelper = DatabaseHelper.instance;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> saveContacts(List<Contact> contacts) async {
    for (int i = 0; i < contacts.length; i++) {
      Map<String, dynamic> row = {
        DatabaseHelper.columnName: contacts[i].displayName ?? "",
        DatabaseHelper.columnPhone: Helper.getPhones(contacts[i].phones)
      };
      await dbHelper.insert(row);
    }
  }

  Future<void> deleteAllContacts() async {
    await dbHelper.deleteTable();
  }

  Future<List<DbContact>> getAllContacts() async {
    // List<Contact> contacts = [];
    List<DbContact> head = [];
    List<DbContact> mid = [];
    List<DbContact> tail = [];
    List<Map<String, dynamic>> contactsList = await dbHelper.queryAllRows();
    for (int i = 0; i < contactsList.length; i++) {
      var contact = DbContact.fromJson(contactsList[i]);
      if (contact != null) {
        if ((contact.name ?? " ").trim().startsWith(RegExp(r'[a-zA-Z]'))) {
          head.add(contact);
        } else if ((contact.name ?? " ").trim().startsWith(RegExp(r'[0-9]'))) {
          mid.add(contact);
        } else
          tail.add(contact);
      }
    }

    return head + mid + tail;
  }
}
