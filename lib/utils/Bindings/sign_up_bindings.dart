import 'package:get/get.dart';
import 'package:testmentor/controllers/signin_controller.dart';

import '../../controllers/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(
      () => SignUpController(),
      // fenix: true,
    );
  }
}
