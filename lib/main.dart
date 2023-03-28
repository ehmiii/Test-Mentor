import 'package:flutter/material.dart';
import 'package:testmentor/pages/SettingPage/setting_page.dart';

import 'pages/HomePage/home_page.dart';
import 'pages/IntialPage/intial_page.dart';
import 'pages/McqsLengthSelectionPage/McqsLengthSelectionPage.dart';
import 'pages/McqsPage/mcqs_page.dart';
import 'pages/SubCategoryPage/sub_category_page.dart';
import 'pages/TestPage/test_page.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Mentor',
      theme: ThemeData(primarySwatch: Constants.DARK_BLUE_COLOR_MATERIAL_COLOR),
      // home: const InitialPage(),
      home: HomePage(),
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
