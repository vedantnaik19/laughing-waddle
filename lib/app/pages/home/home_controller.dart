// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:contacts/app/data/models/db_contact.dart';
import 'package:contacts/app/services/local_db_service.dart';

import '../../../app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  final LocalDbService _localDbService = Get.find();
  final AppController _appController = Get.find();
  RxList<DbContact> contacts = RxList<DbContact>.empty();
  StreamSubscription _syncSub;

  int get contactsCount => contacts.value.length;
  AppController get appController => _appController;
  RxBool get isSynching => _appController.isSyncing;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    GetUtils.printFunction("HomeController: ", state, "");
    if (state == AppLifecycleState.resumed) {
      _getContacts();
    }
  }

  @override
  void onReady() {
    _getContacts();
    _syncSub = _appController.isSyncing.stream.skip(2).listen((val) {
      _getContacts(toSync: false);
    });
    super.onReady();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _syncSub?.cancel();
    super.onClose();
  }

  Future<void> _getContacts({bool toSync = true}) async {
    try {
      List<DbContact> list = await _localDbService.getAllContacts();
      contacts(list);
      if (toSync) _appController.contactsCheck();
    } catch (e) {
      _appController.handleError(e);
    }
  }
}
