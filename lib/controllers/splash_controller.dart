import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SplashController extends GetxController {
  bool _isAdmin = false;
  bool get getIsAdmin => _isAdmin;
  final _userInfoBox = Hive.box("UserInfo");

  set setIsAdmin(bool value) {
    _isAdmin = value;
  }

  Future<bool> tryAutoLogin() async {
    if (_userInfoBox.isEmpty) {
      return false;
    } else if (_userInfoBox.length != 2) {
      await _userInfoBox.deleteFromDisk();
      return false;
    } else {
      return true;
    }
  }

  @override
  void onInit() {
    for (var key in _userInfoBox.keys) {
      // print(_userInfoBox.get(key)['isAdmin']);
      if (_userInfoBox.get(key)['isAdmin'] != null) {
        setIsAdmin = _userInfoBox.get(key)['isAdmin'];
      }
    }
    super.onInit();
  }
}
