import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/mcqs_model.dart';
import '../models/user_information_model.dart';
import '../utils/widgets/show_toast.dart';
import 'home_controller.dart';

class AddMcqsController extends GetxController {
  final _questionController = TextEditingController();
  final _wrongAnswer1Controller = TextEditingController();
  final _wrongAnswer2Controller = TextEditingController();
  final _wrongAnswer3Controller = TextEditingController();
  final _rightAnswerController = TextEditingController();
  final _textFormGlobalKey = GlobalKey<FormState>();
  final UserInformationModel _userInformationModel =
      Get.find<HomeController>().getUserInfo!;
  final _wrongAnswerHintText = "Wrong Answer";
  final _rightAnswerHintText = "Right Answer";

  final _isLoading = false.obs;
  McqsModel? _addmcqs;

  List<String> _listHintText = [];

  List<TextEditingController> _addMcqsControllers = [];

  TextEditingController get getQuestionController => _questionController;
  TextEditingController get getWrongAnswer1Controller =>
      _wrongAnswer1Controller;
  TextEditingController get getWrongAnswer2Controller =>
      _wrongAnswer2Controller;
  TextEditingController get getWrongAnswer3Controller =>
      _wrongAnswer3Controller;
  TextEditingController get getRightAnswerController => _rightAnswerController;
  List<TextEditingController> get getAddMcqsController => _addMcqsControllers;
  List<String> get getListHintText => _listHintText;
  GlobalKey<FormState> get getTextFormGlobalKey => _textFormGlobalKey;
  UserInformationModel get getUserInformation => _userInformationModel;
  bool get getIsLoading => _isLoading.value;

  set setIsLoading(bool value) {
    _isLoading.value = value;
  }

// Getting all questions related user specialization.
  List<String> checkingQuestionDuplication() {
    List<String> questions = [];
    for (var category in Get.find<HomeController>().getSubjectsMcqs) {
      for (var subject in category.subSubjects) {
        if (subject.subSubjectName == _userInformationModel.specialization) {
          for (var mcqs in subject.mcqs) {
            if (!questions.contains(mcqs.question)) {
              questions.add(mcqs.question);
            }
          }
        }
      }
    }
    return questions;
  }

  Future<void> addMcqs() async {
    if (_textFormGlobalKey.currentState!.validate()) {
      String url =
          "https://testmentor-41a06-default-rtdb.firebaseio.com/pending/${_userInformationModel.userId}.json?";

      try {
        // Follwoing arguments comming from notification page when user click on edit button
        setIsLoading = true;
        _addmcqs = McqsModel(
          uploaderName: _userInformationModel.userName,
          question: _questionController.text,
          wrongAnswer1: _wrongAnswer1Controller.text,
          wrongAnswer2: _wrongAnswer2Controller.text,
          wrongAnswer3: _wrongAnswer3Controller.text,
          rightAnswer: _rightAnswerController.text,
          category: _userInformationModel.specialization,
          userId: _userInformationModel.userId,
        );
        final response = await http.post(
          Uri.parse(url),
          body: json.encode(
            _addmcqs!.toJson(),
          ),
        );
        ShowToast.SHOW_TOAST(
          "Mcqs submitted for review",
        );
        if (Get.arguments != null && Get.arguments[1]) {
          Get.find<HomeController>().deleteNotification(Get.arguments[0]);
        }
        Get.back();
      } catch (error) {
        if (error.toString().contains("Failed host lookup")) {
          ShowToast.SHOW_TOAST("It's seems you don't have internet connection");
        } else {
          ShowToast.SHOW_TOAST(error.toString());
        }
        rethrow;
      } finally {
        setIsLoading = false;
      }
    }
  }

  Future<void> editMcqs() async {
    McqsModel mcqs = Get.arguments[0];
    _questionController.text = mcqs.question;
    _wrongAnswer1Controller.text = mcqs.wrongAnswer1;
    _wrongAnswer2Controller.text = mcqs.wrongAnswer2;
    _wrongAnswer3Controller.text = mcqs.wrongAnswer3;
    _rightAnswerController.text = mcqs.rightAnswer;
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments[1]) {
      editMcqs();
    }
    _addMcqsControllers = [
      _wrongAnswer1Controller,
      _wrongAnswer2Controller,
      _wrongAnswer3Controller,
      _rightAnswerController,
    ];
    _listHintText = [
      _wrongAnswerHintText,
      _wrongAnswerHintText,
      _wrongAnswerHintText,
      _rightAnswerHintText,
    ];
  }

  @override
  onClose() {
    _questionController.dispose();
    _rightAnswerController.dispose();
    _wrongAnswer1Controller.dispose();
    _wrongAnswer2Controller.dispose();
    _wrongAnswer3Controller.dispose();
  }
}
