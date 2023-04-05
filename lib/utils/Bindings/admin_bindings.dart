import 'package:get/get.dart';

import '../../controllers/admin_controller.dart';

class AdminBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminController());
  }
}
