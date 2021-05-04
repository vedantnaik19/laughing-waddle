import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../app/services/local_db_service.dart';
import 'widgets/widget_helper.dart';

class AppController extends GetxController {
  final LocalDbService _localDbService = Get.find();

  RxBool _hasContactPermission = false.obs;
  RxBool _isSyncing = false.obs;
  StreamSubscription _contactsPerSub;

  RxBool get hasContactPermission => _hasContactPermission;
  RxBool get isSyncing => _isSyncing;

  @override
  void onReady() {
    super.onReady();
    _contactsPerSub = _hasContactPermission.listen((val) {
      if (val) _syncContacts();
    });
  }

  @override
  void onClose() {
    _contactsPerSub?.cancel();
    super.onClose();
  }

  showSnack(String message) {
    WidgetHelper.showSnack(message);
  }

  showLoader(bool val, [String msg = '']) {
    WidgetHelper.showLoader(val, msg);
  }

  Future<void> _checkPermission() async {
    try {
      if (!hasContactPermission.value) {
        PermissionStatus status = await Permission.contacts.status;
        hasContactPermission(status.isGranted);
        if (!status.isGranted && !status.isPermanentlyDenied) {
          await Permission.contacts.request();
          var status = await Permission.contacts.status;
          hasContactPermission(status.isGranted);
        } else {
          showSnack("Please grant permission to read contacts from seetings.");
        }
      }
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> _syncContacts() async {
    try {
      if (!isSyncing.value) {
        GetUtils.printFunction("AppController: ", "Syncing contacts...", "");
        isSyncing(true);
        Iterable<Contact> contacts = await ContactsService.getContacts(
            withThumbnails: false, orderByGivenName: true);
        GetUtils.printFunction(
            "AppController: ", contacts.length, "contacts found");
        await _localDbService.deleteAllContacts();
        await _localDbService.saveContacts(contacts.toList());
        GetUtils.printFunction("AppController: ", "Done syncing contacts.", "");
      }
    } catch (e) {
      handleError(e);
    } finally {
      isSyncing(false);
    }
  }

  Future<void> contactsCheck() async {
    await _checkPermission();
    if (hasContactPermission.value) _syncContacts();
  }

  void handleError(e) {
    GetUtils.printFunction("AppController: ", e, "", isError: true);
    showSnack(e.message ?? e.toString());
  }
}
