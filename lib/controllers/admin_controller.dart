import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '/models/mcqs_model.dart';
import '/utils/widgets/show_toast.dart';

import '../models/user_authentication_model.dart';
import '../models/user_information_model.dart';

class AdminController extends GetxController {
  final _userInfoBox = Hive.box("UserInfo");
  // For adding mcqs by admin Side
  final _questionController = TextEditingController();
  final _wrongAnswer1Controller = TextEditingController();
  final _wrongAnswer2Controller = TextEditingController();
  final _wrongAnswer3Controller = TextEditingController();
  final _rightAnswerController = TextEditingController();
  final _rejectionMessage = TextEditingController();
  final _textFormGlobalKey = GlobalKey<FormState>();
  List<String> _listHintText = [];
  String _selectedSpecilization = "";
  List<TextEditingController> _addMcqsControllers = [];
  final _wrongAnswerHintText = "Wrong Answer";
  final _rightAnswerHintText = "Right Answer";
  UserInformationModel? _userInformationModel;
  UserAuthenticationModel? _userData;
  TextEditingController get getQuestionController => _questionController;
  TextEditingController get getRejectionMessage => _rejectionMessage;
  List<TextEditingController> get getAddMcqsController => _addMcqsControllers;
  List<String> get getListHintText => _listHintText;
  GlobalKey<FormState> get getTextFormGlobalKey => _textFormGlobalKey;
  String get getSelectedSpecialization => _selectedSpecilization;
  UserInformationModel get getUserInformation => _userInformationModel!;
  set setSelectedSpecialization(String value) {
    _selectedSpecilization = value;
    update();
  }

  Future<void> addMcqs() async {
    if (_textFormGlobalKey.currentState!.validate()) {
      String url =
          "https://testmentor-41a06-default-rtdb.firebaseio.com/approve/$_selectedSpecilization/${_userInformationModel!.userId}.json?";
      try {
        setIsLoading = true;

        final response = await http.post(
          Uri.parse(url),
          body: json.encode(
            McqsModel(
              uploaderName: _userInformationModel!.userName,
              question: _questionController.text,
              wrongAnswer1: _wrongAnswer1Controller.text,
              wrongAnswer2: _wrongAnswer2Controller.text,
              wrongAnswer3: _wrongAnswer3Controller.text,
              rightAnswer: _rightAnswerController.text,
              category: _selectedSpecilization,
              userId: _userInformationModel!.userId,
            ).toJson(),
          ),
        );
        ShowToast.SHOW_TOAST(
          "Mcqs posted",
        );
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

  //////////////////////////////////////////////////

  bool _isLoading = false;
  String _infoMessage = "";
  String get getInfoMessage => _infoMessage;
  McqsModel _mcqsModel = McqsModel(
      uploaderName: "",
      category: "",
      question: "",
      wrongAnswer1: "",
      wrongAnswer2: "",
      wrongAnswer3: "",
      rightAnswer: "",
      userId: "");

  List<McqsModel> _pendingMcqs = [];
  List<UserInformationModel> _users = [];
  List<McqsModel> get getPendingMcqs => _pendingMcqs;
  List<UserInformationModel> get getusers => _users;
  bool get getIsLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
  }

  Future<void> getPendingMcqsFromDataBase() async {
    String url =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/pending.json?";
    _pendingMcqs = [];

    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (json.decode(response.body) == null) {
        _infoMessage = "Nothing found!!";
        update();
        return;
      }
      _infoMessage = "";
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      jsonResponse.forEach(
        (userId, value) {
          _mcqsModel.userId = userId;
          value.forEach(
            (mcqsId, mcqs) {
              _mcqsModel = McqsModel.fromJson(mcqs);
              _mcqsModel.id = mcqsId;
              _pendingMcqs.add(_mcqsModel);
            },
          );
        },
      );
      update();
    } catch (error) {
      rethrow;
    } finally {
      update();
    }
  }

  Future<void> getUsersDetials() async {
    String url =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/UserDetails.json?";
    try {
      setIsLoading = true;
      update();
      _users = [];
      final response = await http.get(Uri.parse(url));
      if (json.decode(response.body) == null) {
        return;
      }
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      // List<UserInformationModel> newUsers =
      jsonResponse.forEach((key, value) {
        value.forEach((key, value) {
          _users.add(UserInformationModel.fromJson(value));
        });
      });
    } catch (error) {
      print(error);
      ShowToast.SHOW_TOAST("It's seems you don't have internet connection");
    } finally {
      setIsLoading = false;
      update();
    }
  }

  Future<void> approveOrRejectMcqs(int index, {bool isApproved = true}) async {
    String url = isApproved
        ? "https://testmentor-41a06-default-rtdb.firebaseio.com/approve/${_pendingMcqs[index].category}/${_pendingMcqs[index].userId}.json?"
        : "https://testmentor-41a06-default-rtdb.firebaseio.com/notifications/${_pendingMcqs[index].userId}.json?";
    String deleteUrl =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/pending/${_pendingMcqs[index].userId}/${_pendingMcqs[index].id}.json?";
    final deletedMcqs = _pendingMcqs[index];
    try {
      setIsLoading = true;
      update();
      if (!isApproved) {
        _pendingMcqs[index].rejectionMessage = _rejectionMessage.text;
        _rejectionMessage.text = "";
      }
      final deleteResponse = await http.delete(
        Uri.parse(deleteUrl),
      );
      print(deleteResponse);
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          _pendingMcqs[index].toJson(),
        ),
      );
      print(response);

      _pendingMcqs.removeAt(index);
    } catch (error) {
      _pendingMcqs.insert(index, deletedMcqs);
      print(error);
      ShowToast.SHOW_TOAST(error.toString());
      rethrow;
    } finally {
      setIsLoading = false;
      update();
    }
  }

  Future<void> logoutUser() async {
    for (var key in _userInfoBox.keys) {
      _userInfoBox.delete(key);
    }
  }

  @override
  void onInit() async {
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
    if (_userInfoBox.isNotEmpty) {
      for (var key in _userInfoBox.keys) {
        final hiveData = _userInfoBox.get(key);
        if (hiveData['userName'] != null) {
          _userInformationModel = UserInformationModel(
            userName: hiveData["userName"],
            email: hiveData["email"],
            isQuizPassed: hiveData["isQuizPassed"],
            profileImageUrl: hiveData["profileImageUrl"],
            specialization: hiveData["specialization"],
            userId: hiveData["userId"],
            id: hiveData["id"],
            isAdmin: hiveData["isAdmin"],
          );
        } else {
          _userData = UserAuthenticationModel(
            idToken: hiveData["idToken"],
            refreshToken: hiveData["refreshToken"],
            tokenExpiresIn: hiveData["tokenExpiresIn"],
          );
        }
      }
    }
    _selectedSpecilization = _userInformationModel!.specialization;
    await getPendingMcqsFromDataBase();
    await getUsersDetials();

    super.onInit();
  }
}
