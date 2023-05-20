import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '/utils/data/categories_names.dart';
import '/utils/widgets/show_toast.dart';

import '../models/category_model.dart';
import '../models/mcqs_model.dart';
import '../models/subjects_model.dart';
import '../models/user_authentication_model.dart';
import '../models/user_information_model.dart';

class HomeController extends GetxController {
  final _userInfoBox = Hive.box("UserInfo");
  UserInformationModel? _userInfo;
  UserAuthenticationModel? _userData;
  bool _isLoading = false;
  bool _isEditingEnable = false;
  bool _questionErrorSelected = false;
  bool _optionErrorSelected = false;

  final _mcqsCommentController = TextEditingController();
  final _userNameController = TextEditingController();
  String _pickedImage = "";
  String _selectedCategory = "";
  String _errorMessage = "";
  String _userChoice = ""; // Test or Preparation
  String _userSelectedSubjectTitle =
      ""; // Computer science or English saved user selected categories
  List<CategoryModel> _availableCategory = [];
  int _selectedLengthofQuiz = 0;
  McqsModel _mcqsModel = McqsModel(
      uploaderName: "",
      category: "",
      question: "",
      wrongAnswer1: "",
      wrongAnswer2: "",
      wrongAnswer3: "",
      rightAnswer: "",
      userId: "");
  List<McqsModel> _mcqs = [];
  List<McqsModel> _specialistMcqs = [];
  List<McqsModel> _notifications = [];
  // ignore: non_constant_identifier_names
  List<SubjectsModel> _subjects_and_mcqs = [];

  // final List<CategoryModel> _recentViewed = []..length = 5;

  UserInformationModel? get getUserInfo => _userInfo;
  List<SubjectsModel> get getSubjectsMcqs => _subjects_and_mcqs;
  TextEditingController get getUserNameController => _userNameController;
  UserAuthenticationModel get getUserData => _userData!;
  TextEditingController get getMcqsCommentController => _mcqsCommentController;
  String get getUserChoice => _userChoice;
  String get getUserSelectedSubjectTitle => _userSelectedSubjectTitle;
  // List<CategoryModel?>? get getRecentViewed => _recentViewed;
  bool get getQuestionErrorSelected => _questionErrorSelected;
  bool get getOptionErrorSelected => _optionErrorSelected;

  List<CategoryModel> get getAvailabelCategory => _availableCategory;
  bool get getIsLoading => _isLoading;
  bool get getIsEditingEnable => _isEditingEnable;
  List<McqsModel> get getMcqs => _mcqs;
  String get getPickedImage => _pickedImage;
  List<McqsModel> get getSpecialistMcqs => _specialistMcqs;
  List<McqsModel> get getNotifications => _notifications;
  String get getSelectedCategory => _selectedCategory;
  String get errorMessage => _errorMessage;
  int get getSelectedLengthofQuiz => _selectedLengthofQuiz;

  set setIsEditingEnable(bool value) => _isEditingEnable = value;
  set setSelectedLengthofQuiz(int value) => _selectedLengthofQuiz = value;
  set setErrorMessage(String value) => _errorMessage = value;
  set setSelectedCategory(String value) => _selectedCategory = value;
  set setIsLoading(bool value) => _isLoading = value;
  set setQuestionErrorSelected(bool value) => _questionErrorSelected = value;
  set setOptionErrorSelected(bool value) => _optionErrorSelected = value;
  set setUserChoice(String value) => _userChoice = value;
  set setUserSelectedSubjectTitle(String value) =>
      _userSelectedSubjectTitle = value;
  Future<void> logoutUser() async {
    for (var key in _userInfoBox.keys) {
      _userInfoBox.delete(key);
    }
    _userInfo = null;
    _userData = null;
  }

  Future<void> getImage(ImageSource imageSource) async {
    try {
      final pickImage = await ImagePicker().pickImage(source: imageSource);
      _pickedImage = pickImage?.path ?? "";
      update();
    } catch (error) {
      ShowToast.SHOW_TOAST("Image can't picked try again...");
    }
  }

  Future<void> updateUserData() async {
    String url =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/UserDetails/${_userInfo?.userId}/${_userInfo?.id}.json?";
    try {
      setIsLoading = true;
      final response = await http.patch(
        Uri.parse(url),
        body: json.encode(
          UserInformationModel(
            userName: _userNameController.text,
            email: _userInfo!.email,
            userId: _userInfo!.userId,
            specialization: _userInfo!.specialization,
            isQuizPassed: _userInfo!.isQuizPassed,
            profileImageUrl: await uploadUserProfilePic(),
          ).toJson(),
        ),
      );
      print(json.decode(response.body));
    } catch (error) {
      print(error);
      rethrow;
    } finally {
      setIsLoading = false;
    }
  }

  Future<String> uploadUserProfilePic() async {
    if (_pickedImage == "") {
      return _userInfo!.profileImageUrl;
    } else {
      final ref = FirebaseStorage.instance
          .ref()
          .child('UserProfile')
          .child(_userInfo!.userId)
          .child('ProfileImage of ${_userNameController.text}');
      await ref.putFile(File(_pickedImage));
      return await ref.getDownloadURL();
    }
  }

  Future<void> deleteMcqsFromDataBase(McqsModel mcqs) async {
    String url =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/approve/${mcqs.category}/${mcqs.userId}/${mcqs.id}.json?";
    try {
      setIsLoading = true;
      update();
      await http.delete(Uri.parse(url));
      _specialistMcqs.removeWhere((element) => element.id == mcqs.id);
      ShowToast.SHOW_TOAST("Successfully deleted");
    } catch (e) {
      ShowToast.SHOW_TOAST("Mcqs not deleted..");
    } finally {
      setIsLoading = false;
      update();
    }
  }

// Getting mcqs from database also getting notifications from database
  Future<void> getAvaliableCategoriesAndNotifications(
      {bool isGettingNotifications = false}) async {
    String categoryUrl =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/approve.json?";
    String url = categoryUrl;
    if (isGettingNotifications) {
      _notifications = [];
      url =
          "https://testmentor-41a06-default-rtdb.firebaseio.com/notifications/${_userInfo!.userId}.json?";
    }
    try {
      _availableCategory = [];
      List<SubSubject> computerScience = [];
      List<SubSubject> english = [];
      setIsLoading = true;
      update();
      final response = await http.get(Uri.parse(url));
      if (json.decode(response.body) == null) {
        return;
      }
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      jsonResponse.forEach(
        (category, value) {
          _mcqs = [];
          if (isGettingNotifications) {
            _mcqsModel = McqsModel.fromJson(value);
            _mcqsModel.id = category;
            _notifications.add(_mcqsModel);
          } else {
            // if (CategoriesName.COMPUTER_SCIENCE
            //         .firstWhere((element) => element.categoryName == category)
            //         .categoryName ==
            //     category) {
            //   SubSubject subject =
            //       SubSubject(subSubjectName: category, mcqs: []);
            //   _subjects_and_mcqs.add(
            //     SubjectsModel(
            //       subjectName: "Computer Science",
            //       subSubjects: [],
            //     ),
            //   );
            // }
            value.forEach((subjec, value) {
              value.forEach((key, mcqs) {
                _mcqsModel = McqsModel.fromJson(mcqs);
                _mcqsModel.id = key;
                _mcqs.add(_mcqsModel);
              });
            });
            final element = CategoriesName.COMPUTER_SCIENCE
                .where((element) => element.categoryName == category);
            if (element.isNotEmpty) {
              computerScience.add(
                SubSubject(
                  subSubjectName: category,
                  mcqs: _mcqs,
                ),
              );
            } else {
              english.add(
                SubSubject(
                  subSubjectName: category,
                  mcqs: _mcqs,
                ),
              );
            }
            _availableCategory.add(
              CategoriesName.CATEGORIES_NAME
                  .firstWhere((element) => element.categoryName == category),
            );
          }
        },
      );

      _subjects_and_mcqs = [
        SubjectsModel(
          subjectName: "Computer Science",
          subSubjects: computerScience,
        ),
        SubjectsModel(
          subjectName: "English",
          subSubjects: english,
        ),
      ];
      print(_subjects_and_mcqs.length);
      setErrorMessage = "Done";
    } catch (error) {
      if (error.toString().contains("Failed host lookup")) {
        if (!_errorMessage.contains("Please connect to the Internet")) {
          ShowToast.SHOW_TOAST(
            "Please connect to the Internet as you have no connection at the moment",
          );
        }
        setErrorMessage =
            "Please connect to the Internet as you have no connection at the moment";
      } else {
        print(error.toString());
        setErrorMessage = error.toString();
        ShowToast.SHOW_TOAST(error.toString());
      }
    } finally {
      setIsLoading = false;
      update();
    }
  }

  Future<void> getSpecialistPostedMcqs() async {
    String url =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/approve/${_userInfo!.specialization}/${_userInfo!.userId}.json?";
    try {
      _specialistMcqs = [];
      setIsLoading = true;
      final response = await http.get(Uri.parse(url));
      if (json.decode(response.body) == null) {
        return;
      }
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      jsonResponse.forEach((key, mcqs) {
        _mcqsModel = McqsModel.fromJson(mcqs);
        _mcqsModel.id = key;
        _specialistMcqs.add(_mcqsModel);
      });

      print(_mcqs.length);
      update();
    } catch (error) {
      rethrow;
    } finally {
      setIsLoading = false;
      update();
    }
  }

  Future<void> getMcqsFromDataBase(String subject, String category) async {
    for (var subjects in _subjects_and_mcqs) {
      if (subjects.subjectName == subject) {
        _mcqs = (subjects.subSubjects
            .firstWhere((element) => element.subSubjectName == category)
            .mcqs);
      }
    }
    // String url =
    //     "https://testmentor-41a06-default-rtdb.firebaseio.com/approve/$category.json?";
    // _mcqs = [];
    // try {
    //   setIsLoading = true;
    //   final response = await http.get(Uri.parse(url));
    //   if (json.decode(response.body) == null) {
    //     return;
    //   }
    //   final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
    //   jsonResponse.forEach(
    //     (key, value) {
    //       value.forEach((key, mcqs) {
    //         _mcqsModel = McqsModel.fromJson(mcqs);
    //         _mcqsModel.id = key;
    //         _mcqs.add(_mcqsModel);
    //       });
    //     },
    //   );
    //   print(_mcqs.length);
    //   update();
    // } catch (error) {
    //   rethrow;
    // } finally {
    //   setIsLoading = false;
    //   update();
    // }
  }

  Future<void> deleteNotification(McqsModel mcqs) async {
    String url =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/notifications/${mcqs.userId}/${mcqs.id}.json?";
    McqsModel deletedMcqs = mcqs;
    try {
      setIsLoading = true;
      update();
      final response = await http.delete(Uri.parse(url));
      _notifications.removeWhere((element) => element.id == deletedMcqs.id);
      ShowToast.SHOW_TOAST("Successfully deleted");
    } catch (error) {
      ShowToast.SHOW_TOAST(error.toString());
    } finally {
      setIsLoading = false;
      update();
    }
  }

  Future<void> userReport(McqsModel mcqs) async {
    String url =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/notifications/${mcqs.userId}.json?";
    try {
      String rejectionMessage;
      List<String> mcqsQuestion = [];
      if (_optionErrorSelected &&
          _questionErrorSelected &&
          _mcqsCommentController.text.isNotEmpty) {
        rejectionMessage =
            "There is mistake in question and options. user comment: ${_mcqsCommentController.text}";
      } else if (_optionErrorSelected &&
          _questionErrorSelected &&
          _mcqsCommentController.text.isEmpty) {
        rejectionMessage = "There is mistake in question and options.";
      } else if (_optionErrorSelected) {
        rejectionMessage =
            "There is mistake in options. ${_mcqsCommentController.text}";
      } else if (_questionErrorSelected) {
        rejectionMessage =
            "There is mistake in question. ${_mcqsCommentController.text}";
      } else {
        rejectionMessage = _mcqsCommentController.text;
      }
      final getResponse = await http.get(Uri.parse(url));
      if (json.decode(getResponse.body) != null) {
        final jsonResponse =
            json.decode(getResponse.body) as Map<String, dynamic>;
        jsonResponse.forEach(
          (key, value) {
            mcqsQuestion.add(value["question"]);
          },
        );
      }
      if (mcqsQuestion.contains(mcqs.question)) {
        ShowToast.SHOW_TOAST(
            "The report has already been submitted for review.");
      } else {
        final postResponse = await http.post(
          Uri.parse(url),
          body: json.encode(
            McqsModel(
              uploaderName: mcqs.uploaderName,
              category: mcqs.category,
              question: mcqs.question,
              wrongAnswer1: mcqs.wrongAnswer1,
              wrongAnswer2: mcqs.wrongAnswer2,
              wrongAnswer3: mcqs.wrongAnswer3,
              rightAnswer: mcqs.rightAnswer,
              userId: mcqs.userId,
              rejectionMessage: rejectionMessage,
            ).toJson(),
          ),
        );
        ShowToast.SHOW_TOAST(
            "The report has been submitted. Thank you for your correction.");
      }
    } catch (error) {
      ShowToast.SHOW_TOAST(error.toString());
    }
  }

  @override
  void onInit() async {
    // print(_recentViewed);

    if (_userInfoBox.isNotEmpty) {
      for (var key in _userInfoBox.keys) {
        final hiveData = _userInfoBox.get(key);
        if (hiveData['userName'] != null) {
          _userInfo = UserInformationModel(
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
    if (_userInfo != null) {
      _userNameController.text = _userInfo!.userName;
      await getAvaliableCategoriesAndNotifications(
          isGettingNotifications: true);
    }
    await getAvaliableCategoriesAndNotifications();
    super.onInit();
  }

  @override
  void onClose() {
    _mcqsCommentController.dispose();
    _userNameController.dispose();
  }
}
