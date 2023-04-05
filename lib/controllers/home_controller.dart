import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:testmentor/utils/data/categories_names.dart';
import 'package:testmentor/utils/widgets/show_toast.dart';

import '../models/category_model.dart';
import '../models/mcqs_model.dart';
import '../models/user_authentication_model.dart';
import '../models/user_information_model.dart';

class HomeController extends GetxController {
  final _userInfoBox = Hive.box("UserInfo");
  UserInformationModel? _userInfo;
  UserAuthenticationModel? _userData;
  bool _isLoading = false;
  List<CategoryModel> _availableCategory = [];
  String _selectedCategory = "";
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
  // final List<CategoryModel> _recentViewed = []..length = 5;

  UserInformationModel? get getUserInfo => _userInfo;
  UserAuthenticationModel get getUserData => _userData!;
  // List<CategoryModel?>? get getRecentViewed => _recentViewed;
  List<CategoryModel> get getAvailabelCategory => _availableCategory;
  bool get getIsLoading => _isLoading;
  List<McqsModel> get getMcqs => _mcqs;
  String get getSelectedCategory => _selectedCategory;
  int get getSelectedLengthofQuiz => _selectedLengthofQuiz;

  set setSelectedLengthofQuiz(int value) => _selectedLengthofQuiz = value;
  set setSelectedCategory(String value) => _selectedCategory = value;
  set setIsLoading(bool value) => _isLoading = value;
  Future<void> logoutUser() async {
    for (var key in _userInfoBox.keys) {
      _userInfoBox.delete(key);
    }
    _userInfo = null;
    _userData = null;
  }

  Future<void> recentViewed() async {
    final recentDb = await Hive.openBox("RecentDb");
  }

  Future<void> getAvaliableCategories() async {
    String url =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/approve.json?";
    _availableCategory = [];
    try {
      setIsLoading = true;
      final response = await http.get(Uri.parse(url));
      if (json.decode(response.body) == null) {
        return;
      }
      final JsonResponse = json.decode(response.body) as Map<String, dynamic>;
      JsonResponse.forEach((category, value) {
        if (!_availableCategory.contains(category)) {
          _availableCategory.add(
            CategoriesName.CATEGORIES_NAME
                .firstWhere((element) => element.categoryName == category),
          );
        }
      });
    } catch (error) {
      ShowToast.SHOW_TOAST(error.toString());
    } finally {
      setIsLoading = false;
      update();
    }
  }

  Future<void> getMcqsFromDataBase(String category) async {
    String url =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/approve/$category.json?";
    _mcqs = [];
    try {
      final response = await http.get(Uri.parse(url));
      if (json.decode(response.body) == null) {
        return;
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
      print(_mcqs.length);
    } catch (error) {
      rethrow;
    } finally {}
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
      await getAvaliableCategories();
    }
    super.onInit();
  }
}
