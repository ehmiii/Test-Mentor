import 'package:get/get.dart';
import 'package:testmentor/controllers/signup_controller.dart';
import 'package:testmentor/pages/AddMcqsPage/add_mcqs_page.dart';
import 'package:testmentor/pages/AdminPages/UsersDetailsPage/users_details_page.dart';
import 'package:testmentor/pages/AuthenticationPages/SignInPage/sign_in_page.dart';
import 'package:testmentor/pages/AuthenticationPages/SignUpPage/sign_up_page.dart';
import 'package:testmentor/pages/HomePage/home_page.dart';
import 'package:testmentor/pages/IntialPage/intial_page.dart';
import 'package:testmentor/pages/McqsLengthSelectionPage/McqsLengthSelectionPage.dart';
import 'package:testmentor/pages/McqsPage/mcqs_page.dart';
import 'package:testmentor/pages/ProfilePage/profile_page.dart';
import 'package:testmentor/pages/ResultPage/result_page.dart';
import 'package:testmentor/pages/SettingPage/setting_page.dart';
import 'package:testmentor/pages/SplashPage/splash_page.dart';
import 'package:testmentor/pages/SubCategoryPage/sub_category_page.dart';
import 'package:testmentor/pages/TestPage/test_page.dart';

import '../../controllers/home_controller.dart';
import '../../pages/AdminPages/NewMcqsPage/admin_new_mcqs_page.dart';
import '../Bindings/add_mcqs_binding.dart';
import '../Bindings/admin_bindings.dart';
import '../Bindings/home_binding.dart';
import '../Bindings/sign_in_binding.dart';
import '../Bindings/sign_up_bindings.dart';
import '../Bindings/splash_bindings.dart';
import '../Bindings/test_binding.dart';

class Routes {
  static String home = "/";
  static String initail = "/initial";
  static String signin = "/signin";
  static String signup = "/signup";
  static String addmcqs = "/add_mcqs";
  static String mcqslengthselection = "/mcqs_length_selection";
  static String mcqs = "/mcqs";
  static String profile = "/profile";
  static String result = "/result";
  static String setting = "/setting";
  static String subcategory = "/subcategory";
  static String test = "/test";
  static String usersdetails = "/users-details";
  static String adminnewmcqspage = "/admin-new-mcqs";
  static String splash = '/splash';

  static String getSplashPage() => splash;
  static String getHomePage() => home;
  static String getAdminNewMcqsPage() => adminnewmcqspage;
  static String getInitialPage() => initail;
  static String getSignInPage() => signin;
  static String getSignUpPage() => signup;
  static String getAddMcqsPage() => addmcqs;
  static String getMcqsLengthSelectionPage() => mcqslengthselection;
  static String getMcqsPage() => mcqs;
  static String getProfilePage() => profile;
  static String getResultPage() => result;
  static String getSettingPage() => setting;
  static String getSubCategoryPage() => subcategory;
  static String getTestPage() => test;
  static String getUsersDetailsPage() => usersdetails;

  static List<GetPage> routes = [
    GetPage(
      page: () => AdminNewMcqsPage(),
      name: adminnewmcqspage,
    ),
    GetPage(
      page: () => SplashPage(),
      name: splash,
      transition: Transition.downToUp,
      binding: SplashBindings(),
    ),
    GetPage(
      name: home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: initail,
      page: () => InitialPage(),
    ),
    GetPage(
      name: signin,
      page: () => SignInPage(),
      transition: Transition.zoom,
      binding: SignInBinding(),
    ),
    GetPage(
        name: signup,
        page: () => SignUpPage(),
        transition: Transition.zoom,
        binding: SignUpBinding()),
    GetPage(
      name: addmcqs,
      page: () => AddMcqsPage(),
      binding: AddMcqsBinding(),
    ),
    GetPage(name: mcqslengthselection, page: () => McqsLengthSelectionPage()),
    GetPage(
      name: mcqs,
      page: () => McqsPage(),
    ),
    GetPage(
      name: profile,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: result,
      page: () => ResultPage(),
    ),
    GetPage(
      name: setting,
      page: () => SettingPage(),
    ),
    GetPage(
      name: subcategory,
      page: () => SubCategoryPage(),
    ),
    GetPage(
      name: test,
      page: () => TestPage(),
      binding: TestBinding(),
    ),
    GetPage(
      name: usersdetails,
      page: () => UsersDetailsPage(),
      binding: AdminBindings(),
    ),
  ];
}
