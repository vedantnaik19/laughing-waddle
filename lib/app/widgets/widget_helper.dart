import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loader.dart';

class WidgetHelper {
  static showSnack(String message) {
    Get.snackbar(
      null,
      null,
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black.withOpacity(0.9),
      colorText: Colors.white,
      borderRadius: 0,
      margin: EdgeInsets.all(0),
      maxWidth: double.infinity,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static showLoader(bool val, [String msg = '']) {
    if (Get.isDialogOpen && !val) {
      Get.back();
    } else if (val) {
      if (Get.isDialogOpen) Get.back();
      Get.dialog(
          WillPopScope(
              child: SimpleDialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        msg,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Loader(),
                      SizedBox(
                        height: 64,
                      )
                    ],
                  ),
                ],
              ),
              // ignore: missing_return
              onWillPop: () {}),
          barrierDismissible: false,
          barrierColor: Colors.white38);
    }
  }
}
