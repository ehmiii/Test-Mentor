import 'package:get/get.dart';

import '../models/mcqs_model.dart';
import '../utils/extensions/random_list_generation_extension.dart';
import 'home_controller.dart';

class TestController extends GetxController {
  List<McqsModel> _selectedmcqs = [];
  List<String> _currentMcqsAnswers = [];

  int _currentMcqsIndex = 0;
  int _totalTime = 0;
  bool _isTestStart = false;
  List<McqsModel> get getSelectedMcqs => _selectedmcqs;

  int get getCurrentMcqsIndex => _currentMcqsIndex;
  List<String> get getCurrentMcqsAnswers => _currentMcqsAnswers;
  int get getTotalTime => _totalTime;
  bool get getIsTestStart => _isTestStart;
  // set setCurrentMcqsIndex(int value) => _currentMcqsIndex = value;
  set setIsTestStart(bool value) => _isTestStart = value;
  void nextQuestion() {
    if (_currentMcqsIndex < _selectedmcqs.length - 1) {
      _currentMcqsIndex++;
      _currentMcqsAnswers = [
        _selectedmcqs[_currentMcqsIndex].wrongAnswer1,
        _selectedmcqs[_currentMcqsIndex].wrongAnswer2,
        _selectedmcqs[_currentMcqsIndex].wrongAnswer3,
        _selectedmcqs[_currentMcqsIndex].rightAnswer,
      ];
      update();
    }
  }

  // void startTest(Widget child) {
  //   CountdownTimer(
  //     controller: _controller,
  //     widgetBuilder: (_, currentRemainingTime) {
  //       return child;
  //     },
  //   );
  // }

  @override
  void onInit() {
    // _seletedmcqs = Get.find<HomeController>().getMcqs;
    _selectedmcqs = [];

    for (var index = 0;
        index < Get.find<HomeController>().getSelectedLengthofQuiz;
        index++) {
      _selectedmcqs.add(Get.find<HomeController>().getMcqs.randomItem());
    }
    _selectedmcqs.shuffle();
    _currentMcqsAnswers = [
      _selectedmcqs[_currentMcqsIndex].wrongAnswer1,
      _selectedmcqs[_currentMcqsIndex].wrongAnswer2,
      _selectedmcqs[_currentMcqsIndex].wrongAnswer3,
      _selectedmcqs[_currentMcqsIndex].rightAnswer,
    ];
    _currentMcqsAnswers.shuffle();
    _totalTime = _selectedmcqs.length * 72;
    super.onInit();
  }
}
