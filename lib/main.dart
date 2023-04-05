import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testmentor/firebase_options.dart';
import 'package:testmentor/pages/AuthenticationPages/SignUpPage/sign_up_page.dart';
import 'package:testmentor/pages/SettingPage/setting_page.dart';

import 'pages/HomePage/home_page.dart';
import 'pages/IntialPage/intial_page.dart';
import 'pages/McqsLengthSelectionPage/McqsLengthSelectionPage.dart';
import 'pages/McqsPage/mcqs_page.dart';
import 'pages/SubCategoryPage/sub_category_page.dart';
import 'pages/TestPage/test_page.dart';
import 'utils/Bindings/sign_in_binding.dart';
import 'utils/Bindings/sign_up_bindings.dart';
import 'utils/Bindings/splash_bindings.dart';
import 'utils/Routes/routes.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("UserInfo");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialBinding: SignUpBinding(),
      // initialBinding: SignInBinding(),
      initialBinding: SplashBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Test Mentor',
      theme: ThemeData(
        primarySwatch: Constants.DARK_BLUE_COLOR_MATERIAL_COLOR,
      ),
      // initialRoute: Routes.getSignUpPage(),
      initialRoute: Routes.getSplashPage(),
      getPages: Routes.routes,
      // home: const InitialPage(),
      // home: SignUpPage(),
      // home: HomePage(),
      // home: const SubCategoryPage()
      // home: const McqsSelectionPage()
      // home: McqsPage(),
      // home: const TestPage(),
      // home: const ResultPage(),
      // home: const SettingPage(),
      // home: const ProfilePage(),
    );
  }
}
