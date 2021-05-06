// ignore_for_file: invalid_use_of_protected_member

import 'package:contacts/app/utils/helper.dart';
import 'package:contacts/app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: buildAppBar(textTheme),
      body: Obx(
        () => (controller.contacts.value.isEmpty &&
                !controller.isSynching.value)
            ? Center(child: Text("No contacts found"))
            : (controller.contacts.value.isEmpty && controller.isSynching.value)
                ? Center(child: Loader())
                : Scrollbar(
                    controller: _scrollController,
                    showTrackOnHover: true,
                    isAlwaysShown: true,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: controller.contacts.value.length,
                      itemBuilder: (_, i) {
                        int colorIndex = i % Colors.primaries.length;
                        var contact = controller.contacts.value[i];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.primaries[colorIndex],
                            child: Text(
                              Helper.getInitials(contact.name ?? " "),
                              style: textTheme.headline6
                                  .copyWith(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          title: Text(contact.name ?? " "),
                          subtitle: Text(
                            contact.phones,
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  AppBar buildAppBar(TextTheme textTheme) {
    return AppBar(
      elevation: 1,
      title: Text(
        'Contacts',
        style: textTheme.headline6.copyWith(color: Colors.black),
      ),
    );
  }
}
