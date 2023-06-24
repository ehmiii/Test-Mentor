import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '/utils/widgets/show_toast.dart';

import '../models/mcqs_model.dart';
import '../models/user_information_model.dart';

class SignUpController extends GetxController {
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
  List<McqsModel> get getMcqs => _mcqs;

  final RxList _selectedCategories = [].obs;
  final _pickedImage = "".obs;
  final _errorMessage = "".obs;

  final _isPasswordHide = true.obs;
  final _isQuizPassed = false.obs;
  final _isLoading = false.obs;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final _gobalFormKey = GlobalKey<FormState>();
  GlobalKey _scaffoldKey = GlobalKey();

  String _userId = "";

  UserInformationModel? _userInformation;

  // getters
  List get getSeletedCategories => _selectedCategories;

  String get getErrorMessage => _errorMessage.value;
  String get getPickedImage => _pickedImage.value;
  bool get getIsQuizPassed => _isQuizPassed.value;
  bool get getIsPasswordHide => _isPasswordHide.value;
  bool get getIsLoading => _isLoading.value;

  TextEditingController get getUserNameController => _userNameController;
  TextEditingController get getEmailController => _emailController;
  TextEditingController get getPasswordController => _passwordController;
  TextEditingController get getConfirmPasswordController =>
      _passwordConfirmController;
  GlobalKey<FormState> get getGlobalFormKey => _gobalFormKey;
  GlobalKey get getscaffoldKey => _scaffoldKey;

  //setters
  set setSelectedCategories(String categoryName) {
    if (_selectedCategories.contains(categoryName)) {
      _selectedCategories.remove(categoryName);
    } else {
      _selectedCategories.add(categoryName);
    }
    // _selectedCategories.value = categoryName;
  }

  set setIsQuizPassed(bool value) {
    _isQuizPassed.value = value;
  }

  set setIsPasswordHide(bool value) {
    _isPasswordHide.value = value;
  }

  set setIsLoading(bool value) {
    _isLoading.value = value;
  }

  // Getting Image from user
  void getImage(ImageSource imageSource) async {
    try {
      final pickImage = await ImagePicker().pickImage(source: imageSource);
      _pickedImage.value = pickImage?.path ?? "";
      update();
    } catch (error) {
      ShowToast.SHOW_TOAST("Image can't picked try again...");
    }
  }

  // Signing In User to the Database
  Future<void> signUpUser() async {
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBpcCtfcvPD8MjKhfY7GFKftyoU90sVDds";
    try {
      setIsLoading = true;
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            "email": _emailController.text,
            "password": _passwordController.text,
            "returnSecureToken": true,
          },
        ),
      );
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['error'] != null) {
        print(jsonResponse['error']['message']);
        throw Exception(jsonResponse['error']['message']);
      }
      _userId = jsonResponse["localId"];
      _userInformation = UserInformationModel(
        userName: _userNameController.text,
        email: _emailController.text,
        userId: jsonResponse["localId"],
        specialization: _selectedCategories.value,
        isQuizPassed: _isQuizPassed.value,
        profileImageUrl: await uploadUserProfilePic(),
      );
    } catch (error) {
      if (error.toString().contains("EMAIL_EXISTS")) {
        _errorMessage.value = "Email already exists try another";
      } else if (error.toString().contains("OPERATION_NOT_ALLOWED")) {
        _errorMessage.value =
            "Currently you have don't access to get register try again";
      } else if (error.toString().contains("TOO_MANY_ATTEMPTS_TRY_LATER")) {
        _errorMessage.value = "You have block for sometime try later";
      } else if (error.toString().toLowerCase().contains(
            "Failed host lookup".toLowerCase(),
          )) {
        _errorMessage.value = "Make sure you have internet connection";
      } else {
        _errorMessage.value = error.toString();
      }
      // if(_userId.isEmpty){

      // }
      rethrow;
    } finally {
      setIsLoading = false;
    }
  }

  Future<void> uploadUserData() async {
    String url =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/UserDetails/${_userInformation?.userId}.json?";
    try {
      setIsLoading = true;
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          _userInformation!.toJson(),
        ),
      );
      print(json.decode(response.body));
    } catch (error) {
      _errorMessage.value = error.toString();
      rethrow;
    } finally {
      setIsLoading = false;
    }
  }

  Future<String> uploadUserProfilePic() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('UserProfile')
        .child(_userId)
        .child('ProfileImage of ${_userNameController.text}');
    await ref.putFile(File(_pickedImage.value));
    return await ref.getDownloadURL();
  }

  Future<void> getMcqsFromDataBase() async {
    _mcqs = [];
    try {
      for (var category in _selectedCategories) {
        String url =
            "https://testmentor-41a06-default-rtdb.firebaseio.com/approve/$category.json?";
        setIsLoading = true;
        final response = await http.get(Uri.parse(url));
        if (json.decode(response.body) == null) {
          throw Exception();
        }
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

        jsonResponse.forEach(
          (key, value) {
            value.forEach((key, mcqs) {
              _mcqsModel = McqsModel.fromJson(mcqs);
              _mcqsModel.id = key;
              _mcqs.add(_mcqsModel);
            });
          },
        );
        update();
      }
    } catch (error) {
      rethrow;
    } finally {
      setIsLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.onClose();
  }
}
