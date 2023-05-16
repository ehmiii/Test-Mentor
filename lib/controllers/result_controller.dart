import 'package:get/get.dart';
import '/controllers/test_controller.dart';

import '../models/mcqs_model.dart';
import '../models/user_test_mcqs_model.dart';

class ResultController extends GetxController {
  List<UserTestMcqsModel> _userTestMcqsModel = [];
  List<McqsModel> _selectedmcqs = [];

  List<McqsModel> get getSelectedMcqs => _selectedmcqs;
  List<UserTestMcqsModel> get getUserTestMcqsModel => _userTestMcqsModel;
  @override
  void onInit() {
    _userTestMcqsModel = [];
    _userTestMcqsModel = Get.find<TestController>().getUserTestMcqsModel;

    super.onInit();
  }
}
