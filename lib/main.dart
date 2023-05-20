import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gat_cs_trainer_app/pages/SplashPage/splash_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/firebase_options.dart';

import 'utils/Bindings/splash_bindings.dart';
import 'utils/Routes/routes.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        // initialBinding: SignUpBinding(),
        // initialBinding: SignInBinding(),
        initialBinding: SplashBindings(),
        debugShowCheckedModeBanner: false,
        title: 'GAT(CS) Trainer App',
        theme: ThemeData(
          // useMaterial3: true,
          primarySwatch: Constants.DARK_BLUE_COLOR_MATERIAL_COLOR,
          fontFamily: GoogleFonts.roboto().fontFamily,
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
      ),
    );
  }
}
