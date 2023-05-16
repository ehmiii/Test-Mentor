import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'signup_controller.dart';
import '../utils/Routes/routes.dart';
import '../utils/constants.dart';

import '../models/mcqs_model.dart';
import '../models/user_test_mcqs_model.dart';
import '../utils/extensions/random_list_generation_extension.dart';
import 'home_controller.dart';

class TestController extends GetxController {
  bool _isTestStart = false;
  int _currentMcqsIndex = 0;
  int _totalTime = 0;
  String _remainingtime = "";
  double _obtainedMarks = 0;
  double _skippedMcqs = 0;
  double _wrongAnswerByUser = 0;
  bool _isReportGenerated = false;

  List<McqsModel> _selectedmcqs = [];
  List<UserTestMcqsModel> _userTestMcqsModel = [];
  List<String> _currentMcqsAnswers = [];
  Timer? _timer;

  List<McqsModel> get getSelectedMcqs => _selectedmcqs;
  List<String> get getCurrentMcqsAnswers => _currentMcqsAnswers;
  int get getCurrentMcqsIndex => _currentMcqsIndex;
  int get getTotalTime => _totalTime;
  String get getRemainingTime => _remainingtime;
  bool get getIsTestStart => _isTestStart;
  bool get getIsReportGenerated => _isReportGenerated;
  double get getObtainedMarks => _obtainedMarks;
  double get getSkippedMcqs => _skippedMcqs;
  Timer? get getTimer => _timer;
  double get getWrongAnswerByUser => _wrongAnswerByUser;
  List<UserTestMcqsModel> get getUserTestMcqsModel => _userTestMcqsModel;
  // set setCurrentMcqsIndex(int value) => _currentMcqsIndex = value;

  set setIsTestStart(bool value) => _isTestStart = value;
  set setIsReportGenerated(bool value) => _isReportGenerated = value;
  set setObtainedMarks(double marks) => _obtainedMarks = marks;
  set setSkippedMcqs(double skiped) => _skippedMcqs = skiped;
  set setWrongAnswerByUser(double wrong) => _wrongAnswerByUser = wrong;

  void setUserTestMcqs(
          {required McqsModel userMcqs, required String userEnteredAnswer}) =>
      _userTestMcqsModel.add(
        UserTestMcqsModel(
          question: userMcqs.question,
          wrongAnswer1: userMcqs.wrongAnswer1,
          wrongAnswer2: userMcqs.wrongAnswer2,
          wrongAnswer3: userMcqs.wrongAnswer3,
          rightAnswer: userMcqs.rightAnswer,
          userEnteredAnswer: userEnteredAnswer,
        ),
      );

  void nextQuestion() {
    if (_currentMcqsIndex < _selectedmcqs.length - 1) {
      _currentMcqsIndex++;
      _currentMcqsAnswers = [
        _selectedmcqs[_currentMcqsIndex].wrongAnswer1,
        _selectedmcqs[_currentMcqsIndex].wrongAnswer2,
        _selectedmcqs[_currentMcqsIndex].wrongAnswer3,
        _selectedmcqs[_currentMcqsIndex].rightAnswer,
      ];
      _currentMcqsAnswers.shuffle();
      update();
    }
  }

  void testTimer() {
    if (_timer == null) {
      const duration = Duration(seconds: 1);
      int remainingSeconds = _totalTime;
      _timer = Timer.periodic(duration, (Timer timer) {
        if (remainingSeconds == 0) {
          timer.cancel();
          Get.offAndToNamed(Routes.getResultPage());
        } else {
          int minutes = remainingSeconds ~/ 60;
          int seconds = (remainingSeconds % 60);
          _remainingtime =
              "${minutes.toString().padLeft(2, "0")}Min ${seconds.toString().padLeft(2, "0")}Sec";
          remainingSeconds--;
          update();
        }
      });
    }
  }

  Future<void> getSelectedMcqsMethod({
    required int lengthOfSelectedMcqs,
    required List<McqsModel> mcqs,
    bool isSingupTest = false,
  }) async {
    if (mcqs.length > lengthOfSelectedMcqs) {
      while (_selectedmcqs.length < lengthOfSelectedMcqs) {
        McqsModel pickedMcqs = mcqs.randomItem();
        if (!_selectedmcqs.contains(pickedMcqs)) {
          _selectedmcqs.add(pickedMcqs);
        }
      }
    } else {
      for (var index = 0; index < lengthOfSelectedMcqs; index++) {
        _selectedmcqs.add(mcqs.randomItem());
      }
    }
    _selectedmcqs.shuffle();
    _currentMcqsAnswers = [
      _selectedmcqs[_currentMcqsIndex].wrongAnswer1,
      _selectedmcqs[_currentMcqsIndex].wrongAnswer2,
      _selectedmcqs[_currentMcqsIndex].wrongAnswer3,
      _selectedmcqs[_currentMcqsIndex].rightAnswer,
    ];
    _currentMcqsAnswers.shuffle();
    if (isSingupTest) {
      _totalTime = 300;
    } else {
      _totalTime = _selectedmcqs.length * 72;
    }

    _remainingtime = Constants.FORMATE_TIME(_totalTime);
  }

  @override
  void onInit() {
    // _seletedmcqs = Get.find<HomeController>().getMcqs;
    _selectedmcqs = [];
    if (Get.isRegistered<HomeController>()) {
      getSelectedMcqsMethod(
        lengthOfSelectedMcqs:
            Get.find<HomeController>().getSelectedLengthofQuiz,
        mcqs: Get.find<HomeController>().getMcqs,
      );
    } else if (Get.isRegistered<SignUpController>()) {
      getSelectedMcqsMethod(
        lengthOfSelectedMcqs: 10,
        mcqs: Get.find<SignUpController>().getMcqs,
        isSingupTest: true,
      );
    }
    super.onInit();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }
}
