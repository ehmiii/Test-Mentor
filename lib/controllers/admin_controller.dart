import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:testmentor/models/mcqs_model.dart';
import 'package:testmentor/utils/widgets/show_toast.dart';

import '../models/user_information_model.dart';

class AdminController extends GetxController {
  final _userInfoBox = Hive.box("UserInfo");

  bool _isLoading = false;
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
        throw Exception("Nothing found!!");
      }
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

  Future<void> aprroveMcqs(int index) async {
    String url =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/approve/${_pendingMcqs[index].category}/${_pendingMcqs[index].userId}.json?";
    String deleteUrl =
        "https://testmentor-41a06-default-rtdb.firebaseio.com/pending/${_pendingMcqs[index].userId}/${_pendingMcqs[index].id}.json?";
    final deletedMcqs = _pendingMcqs[index];
    try {
      setIsLoading = true;
      update();
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          _pendingMcqs[index].toJson(),
        ),
      );
      final deleteResponse = await http.delete(
        Uri.parse(deleteUrl),
      );
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
    await getPendingMcqsFromDataBase();
    await getUsersDetials();
    super.onInit();
  }
}
