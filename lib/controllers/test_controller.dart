import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/data/categories_names.dart';
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
  bool _isGatOpenForFirstTime = true;

  List<McqsModel> _selectedmcqs = [];
  List<UserTestMcqsModel> _userTestMcqsModel = [];
  List<String> _currentMcqsAnswers = [];
  Timer? _timer;
  final List<Map<String, String>> _shuffledMcqsQuestionAnswers = [];
  final List<Map<String, String>?>? _userAnsweredQuestions = [];
  String _clickedMcqsOption = "";
  int _examTakingTime = 0;

  bool get getIsGatOpenForFirstTime => _isGatOpenForFirstTime;
  int get getExamTakingTime => _examTakingTime;
  String get getClickedMcqsOption => _clickedMcqsOption;
  List<Map<String, String>?>? get getUserAnsweredQuestions =>
      _userAnsweredQuestions;
  // int? get getClickedMcqsIndex => _clickedMcqsIndex;
  List<McqsModel> get getSelectedMcqs => _selectedmcqs;
  List<String> get getCurrentMcqsAnswers => _currentMcqsAnswers;

  List<Map<String, String>> get getShuffledMcqsQuestionAnswers =>
      _shuffledMcqsQuestionAnswers;
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
  set setClickedMcqsOption(String value) => _clickedMcqsOption = value;
  // set setClickedMcqsIndex(int value) => _clickedMcqsIndex = value;
  set setIsGatOpenForFirstTime(bool value) => _isGatOpenForFirstTime = value;

  void setUserTestMcqs(
      {required McqsModel userMcqs, required String userEnteredAnswer}) {
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
    _userAnsweredQuestions!
        .add({"Question": userMcqs.question, "Option": userEnteredAnswer});
  }

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
          _examTakingTime = _totalTime - remainingSeconds;
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
      _totalTime = _selectedmcqs.length * 50;
    }

    _remainingtime = Constants.FORMATE_TIME(_totalTime);
  }

  // void shuffleAllGatMcqsAnswer() {
  //   for (int index = 0; index < _selectedmcqs.length; index++) {
  //     List<String> answers = [
  //       _selectedmcqs[index].wrongAnswer1,
  //       _selectedmcqs[index].wrongAnswer2,
  //       _selectedmcqs[index].wrongAnswer3,
  //       _selectedmcqs[index].rightAnswer,
  //     ];
  //     answers.shuffle();
  //     _shuffledMcqsQuestionAnswers.add({
  //       "Question": _selectedmcqs[index].question,
  //       "A": answers[0],
  //       "B": answers[1],
  //       "C": answers[2],
  //       "D": answers[3],
  //     });
  //   }
  // }

  void gatsimulationTestMcqsSelection() {
    _selectedmcqs = [];
    // Following variable stores lenght of mcqs of each subject for computer science
    List<int> computerPrecentages = [
      10,
      7,
      4,
      4,
      6,
      9,
      7,
      6,
      5,
      5,
      5,
      5,
      6,
      6,
      5,
      5,
      5,
    ];

    // Following variable stores lenght of mcqs of each subject for computer science
    List<int> englishPrecentage = [15, 15];
    // Following map variable stores subject name and there length of mcqs to be picked
    List<Map<String, int>> computerSubjects = [];
    List<Map<String, int>> englishSubjects = [];

    // Following list stores picked mcqs for test
    List<McqsModel> computerSciencePickedMcqs = [];
    List<McqsModel> englishPickedMcqs = [];

    // Following loop adding subject and there length of mcqs to be picked it is for computer science subjects
    for (var index = 0; index < computerPrecentages.length; index++) {
      computerSubjects.add({
        CategoriesName.COMPUTER_SCIENCE[index].categoryName:
            computerPrecentages[index]
      });
    }
    // Following loop adding subject and there length of mcqs to be picked it is for english subjects
    for (var index = 0; index < englishPrecentage.length; index++) {
      englishSubjects.add(
        {CategoriesName.ENGLISH[index].categoryName: englishPrecentage[index]},
      );
    }

    // Following loop picking mcqs for computer science subjects
    for (var element in computerSubjects) {
      element.forEach((key, value) {
        Get.find<HomeController>().getMcqsFromDataBase("Computer Science", key);
        int getedMcqsLength = 0;
        while (getedMcqsLength < value) {
          McqsModel randomMcqs =
              Get.find<HomeController>().getMcqs.randomItem();
          if (!computerSciencePickedMcqs.contains(randomMcqs)) {
            computerSciencePickedMcqs.add(randomMcqs);
            getedMcqsLength++;
          }
        }
      });
    }
    // Following loop picking mcqs for English subjects
    for (var element in englishSubjects) {
      element.forEach((key, value) {
        Get.find<HomeController>().getMcqsFromDataBase("English", key);
        int getedMcqsLength = 0;
        while (getedMcqsLength < value) {
          McqsModel randomMcqs =
              Get.find<HomeController>().getMcqs.randomItem();
          if (!englishPickedMcqs.contains(randomMcqs)) {
            englishPickedMcqs.add(randomMcqs);

            getedMcqsLength++;
          }
        }
      });
    }

    Map<String, int> computerAndEnglishMcqsLength = {
      "Computer": 70,
      "English": 30,
    };
    computerAndEnglishMcqsLength.forEach((key, value) {
      int pickedMcqsIndex = 0;
      while (pickedMcqsIndex < value) {
        McqsModel? randomMcqs;
        if (key == "Computer") {
          randomMcqs = computerSciencePickedMcqs.randomItem();
        } else {
          randomMcqs = englishPickedMcqs.randomItem();
        }
        if (!_selectedmcqs.contains(randomMcqs)) {
          _selectedmcqs.add(randomMcqs);
          List<String> answers = [
            randomMcqs.wrongAnswer1,
            randomMcqs.wrongAnswer2,
            randomMcqs.wrongAnswer3,
            randomMcqs.rightAnswer,
          ];
          answers.shuffle();
          _shuffledMcqsQuestionAnswers.add({
            "Question": randomMcqs.question,
            "A": answers[0],
            "B": answers[1],
            "C": answers[2],
            "D": answers[3],
          });
          pickedMcqsIndex++;
        }
      }
    });
    _totalTime = _selectedmcqs.length * 72;
  }

  @override
  void onInit() {
    // _seletedmcqs = Get.find<HomeController>().getMcqs;
    _selectedmcqs = [];
    if (Get.isRegistered<HomeController>()) {
      if (Get.find<HomeController>().getUserChoice == "GATTest") {
        gatsimulationTestMcqsSelection();
      } else {
        getSelectedMcqsMethod(
          lengthOfSelectedMcqs:
              Get.find<HomeController>().getSelectedLengthofQuiz,
          mcqs: Get.find<HomeController>().getMcqs,
        );
      }
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
