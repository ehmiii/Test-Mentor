import 'package:get/get.dart';

import '../../controllers/add_mcqs_controller.dart';

class AddMcqsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddMcqsController());
  }
}
