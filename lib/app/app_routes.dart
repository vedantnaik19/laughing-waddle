import 'package:get/get.dart';
import 'pages/home/home_page.dart';
import 'pages/home/home_binding.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: '/home',
      page: () => HomePage(),
      binding: HomeBinding(),
    )
  ];
}
