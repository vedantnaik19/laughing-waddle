import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'app/app_binding.dart';
import 'app/app_routes.dart';
import 'app/core/theme.dart/app_theme.dart';
import 'app/core/constants/app_contants.dart';

Future<void> main() async {
  await init();
  runApp(
    GetMaterialApp(
      title: 'Contacts',
      debugShowCheckedModeBanner: false,
      enableLog: true,
      getPages: AppRoutes.pages,
      initialRoute: '/home',
      theme: AppTheme.getTheme(),
      initialBinding: AppBinding(),
    ),
  );
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox(AppConstants.BOX_NAME);
}
