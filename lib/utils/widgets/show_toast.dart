import 'package:fluttertoast/fluttertoast.dart';
import '/utils/constants.dart';

class ShowToast {
  static SHOW_TOAST(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Constants.DARK_BLUE_COLOR,
        textColor: Constants.LIGHT_BLUE_COLOR,
        fontSize: 16.0);
  }
}
