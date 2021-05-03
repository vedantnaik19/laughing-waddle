import 'package:get/instance_manager.dart';

import 'app_controller.dart';
import 'services/local_db_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocalDbService());

    Get.put(AppController());
  }
}
