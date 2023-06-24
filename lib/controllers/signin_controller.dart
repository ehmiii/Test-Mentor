import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gat_cs_trainer_app/utils/widgets/show_toast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../models/user_information_model.dart';

class SignInController extends GetxController {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _isLoading = false.obs;
  final _isPasswordHide = true.obs;
  final _userInfoBox = Hive.box("UserInfo");
  final _formKey = GlobalKey<FormState>();

  String _errorMessage = "";
  String _userId = "";

  UserInformationModel? _userInfo;

  // Map<String, dynamic> _userAuthenticationData = {};

  GlobalKey _scaffoldKey = GlobalKey();

  UserInformationModel get getUserInfo => _userInfo!;

  bool get getIsLoading => _isLoading.value;
  bool get getIsPasswordHide => _isPasswordHide.value;

  String get geterrorMessage => _errorMessage;

  GlobalKey get getScaffoldKey => _scaffoldKey;

  TextEditingController get getEmailController => _emailController;
  TextEditingController get getPasswordController => _passwordController;
  GlobalKey<FormState> get getFormKey => _formKey;

  set setIsLoading(bool value) {
    _isLoading.value = value;
  }

  set setIsPasswordHide(bool value) {
    _isPasswordHide.value = value;
  }

  Future<void> singInUser() async {
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBpcCtfcvPD8MjKhfY7GFKftyoU90sVDds";
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
        throw Exception(jsonResponse['error']['message']);
      }
      _userId = jsonResponse["localId"];
      _userInfoBox.add({
        "idToken": jsonResponse["idToken"],
        "tokenExpiresIn": jsonResponse["expiresIn"],
        "refreshToken": jsonResponse["refreshToken"],
      });
    } catch (error) {
      if (error.toString().contains("EMAIL_NOT_FOUND")) {
        _errorMessage = "Your email doesn't exist";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        _errorMessage = "Password is not correct";
      } else if (error.toString().contains("TOO_MANY_ATTEMPTS_TRY_LATER")) {
        _errorMessage =
            "Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.";
      } else if (error.toString().contains("USER_DISABLED")) {
        _errorMessage =
            "Currently you account is disable do to some legal's issues";
      } else if (error.toString().contains("Failed host lookup")) {
        _errorMessage = "It seems you don't have internet connection";
      } else {
        _errorMessage = error.toString();
      }
      rethrow;
    } finally {
      setIsLoading = false;
    }
  }

  Future<void> getUserData() async {
    String url =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/UserDetails/$_userId.json?";
    try {
      setIsLoading = true;
      final response = await http.get(Uri.parse(url));
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      jsonResponse.forEach((key, value) {
        _userInfo = UserInformationModel.fromJson(value);
        _userInfo!.id = key.toString();
      });
      _userInfoBox.add(_userInfo?.toJson());
      print(_userInfoBox.length);
    } catch (error) {
      _errorMessage = error.toString();
      rethrow;
    } finally {
      setIsLoading = false;
    }
  }

  Future<void> forgetPassword() async {
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyBpcCtfcvPD8MjKhfY7GFKftyoU90sVDds";
    try {
      final respons = await http.post(Uri.parse(url), body: {
        "requestType": "PASSWORD_RESET",
        "email": _emailController.text
      });
      final decodedRespon = jsonDecode(respons.body) as Map<String, dynamic>;
      print(decodedRespon);
      if (decodedRespon.containsKey('error')) {
        print('wewr');
        if (decodedRespon['error']['message'] == "EMAIL_NOT_FOUND") {
          // ShowToast.SHOW_TOAST(
          //     "Given email not found. Please enter correct email");
          throw Exception("Given email not found. Please enter correct email");
        } else if (decodedRespon['error']['message'] ==
            "RESET_PASSWORD_EXCEED_LIMIT") {
          // ShowToast.SHOW_TOAST("");
          throw Exception(
            "Reset Password limit exceeded try later...",
          );
        }
      }
      ShowToast.SHOW_TOAST(
        "Reset Password link send to your",
      );
      _emailController.text = "";
    } catch (e) {
      throw Exception(
        "link was not send to your given email. Please try again",
      );
    }
  }

  @override
  void onClose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.onClose();
  }
}
