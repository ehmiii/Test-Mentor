import 'package:gat_cs_trainer_app/pages/GATTestSimulationPage/gat_test_simulation_page.dart';
import 'package:get/get.dart';
import '../../pages/AdminPages/AdminMcqsDetailPage/admin_mcqs_detail_page.dart';
import '../../pages/TestPage/test_page.dart';
import '/controllers/signup_controller.dart';
import '/pages/AddMcqsPage/add_mcqs_page.dart';
import '/pages/AdminPages/UsersDetailsPage/users_details_page.dart';
import '/pages/AuthenticationPages/SignInPage/sign_in_page.dart';
import '/pages/AuthenticationPages/SignUpPage/sign_up_page.dart';
import '/pages/IntialPage/intial_page.dart';
import '/pages/McqsLengthSelectionPage/McqsLengthSelectionPage.dart';
import '/pages/McqsPage/mcqs_page.dart';
import '/pages/ProfilePage/profile_page.dart';
import '/pages/ResultPage/result_page.dart';
import '/pages/SettingPage/setting_page.dart';
import '/pages/SplashPage/splash_page.dart';
import '/pages/SubCategoryPage/sub_category_page.dart';
import '/pages/SubjectsPage/subjects_page.dart';

import '../../pages/AdminPages/NewMcqsPage/admin_new_mcqs_page.dart';
import '../../pages/HomePage/home_page.dart';
import '../../pages/NotificationPage/notification_page.dart';
import '../../pages/SubjectsSelectionPage/subjects_selection_page.dart';
import '../../pages/TestHistoryPage/test_history_page.dart';
import '../Bindings/add_mcqs_binding.dart';
import '../Bindings/admin_bindings.dart';
import '../Bindings/home_binding.dart';
import '../Bindings/result_binding.dart';
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
  static String testhistory = "/test-history";
  static String notification = "/notification";
  static String subjects = "/subjects";
  static String subjectsselection = "/subjectsselection";
  static String gattestsimulation = "/gattestsimulation";
  static String adminmcqsdetail = "/adminmcqsdetail";

  static String getSubjectsSelection() => subjectsselection;
  static String getSplashPage() => splash;
  static String getHomePage() => home;
  static String getNotificationPage() => notification;
  static String getTestHistoryPage() => testhistory;
  static String getSubjectsPage() => subjects;
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
  static String getGatTestSimulationPage() => gattestsimulation;
  static String getAdminMcqsDetailPage() => adminmcqsdetail;

  static List<GetPage> routes = [
    GetPage(
      name: adminmcqsdetail,
      page: () => AdminMcqsDetailPage(),
    ),
    GetPage(
      page: () => TestHistoryPage(),
      name: testhistory,
    ),
    GetPage(
        name: gattestsimulation,
        page: () => GatTestSimulationPage(),
        binding: TestBinding()),
    GetPage(
      page: () => SubjectsSelectionPage(),
      name: subjectsselection,
    ),
    GetPage(
      page: () => const NotificationPage(),
      name: notification,
    ),
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
      name: subjects,
      page: () => SubjectsPage(),
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
      binding: ResultBinding(),
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
    GetPage(name: usersdetails, page: () => UsersDetailsPage(), bindings: [
      AdminBindings(),
      AddMcqsBinding(),
    ]),
  ];
}
