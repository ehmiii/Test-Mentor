// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/home_controller.dart';
import '/controllers/signin_controller.dart';
import '/models/user_information_model.dart';
import '/utils/Routes/routes.dart';

import '../../SubjectsPage/subjects_page.dart';
import '../../ProfilePage/profile_page.dart';
import '../../SettingPage/setting_page.dart';
import '../../../utils/constants.dart';

class CustomDrawer {
  static Widget CUSTOM_DRAWER(BuildContext context) {
    UserInformationModel? userInfo = Get.find<HomeController>().getUserInfo;
    const double spaceBetweenListTile = 4;
    return SafeArea(
      child: ListTileTheme(
        textColor: Constants.DARK_BLUE_COLOR,
        iconColor: Constants.DARK_BLUE_COLOR,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Constants.LIGHT_BLUE_COLOR,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Get.find<HomeController>().getUserInfo == null
                  ? ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed(
                          Routes.getSignInPage(),
                        );
                      },
                      child: const Text("Specialist? SignIn"),
                    )
                  : Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(flex: 4, child: Container()),
                            Container(
                              width: 100.0,
                              height: 100.0,
                              margin: const EdgeInsets.only(
                                top: 5.0,
                                bottom: 10.0,
                              ),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Constants.DARK_BLUE_COLOR,
                                ),
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: userInfo!.profileImageUrl,
                                  placeholder: (_, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: Constants.LIGHT_BLUE_COLOR,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    Constants.PROFILE_IMAGE,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(flex: 1, child: Container()),
                            ElevatedButton(
                              onPressed: () {
                                Get.find<HomeController>().logoutUser().then(
                                      (value) => Get.offAllNamed(
                                        Routes.getInitialPage(),
                                      ),
                                    );
                              },
                              child: const Text("Logout"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: spaceBetweenListTile,
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(
                            Icons.person,
                          ),
                          title: Text(
                            userInfo.userName,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: spaceBetweenListTile,
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(
                            Icons.email_outlined,
                          ),
                          title: Text(
                            userInfo.email,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: spaceBetweenListTile,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SubjectsPage(),
                    ),
                  );
                },
                leading: const Icon(Icons.home),
                title: const Text('Home'),
              ),
              const SizedBox(
                height: spaceBetweenListTile,
              ),
              Get.find<HomeController>().getUserInfo == null
                  ? const SizedBox()
                  : ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ProfilePage(),
                          ),
                        );
                      },
                      leading: const Icon(Icons.account_circle_rounded),
                      title: const Text('Profile'),
                    ),
              const SizedBox(
                height: spaceBetweenListTile,
              ),
              ListTile(
                onTap: () {
                  // Get.toNamed(Routes.getTestPage());
                },
                leading: const Icon(Icons.quiz),
                title: const Text('Drill Test'),
              ),
              const SizedBox(
                height: spaceBetweenListTile,
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.menu_book_outlined),
                title: const Text('Test Guidelines'),
              ),
              const SizedBox(
                height: spaceBetweenListTile,
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.getTestHistoryPage());
                },
                leading: const Icon(Icons.history),
                title: const Text('Test History'),
              ),
              const SizedBox(
                height: spaceBetweenListTile,
              ),
              // ListTile(
              //   onTap: () {},
              //   leading: const Icon(
              //     Icons.star_rate_rounded,
              //   ),
              //   title: const Text('Rate Us'),
              // ),
              // const SizedBox(
              //   height: spaceBetweenListTile,
              // ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.info_outline_rounded,
                ),
                title: const Text('About Us'),
              ),
              const SizedBox(
                height: spaceBetweenListTile,
              ),
              const Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 15,
                  color: Constants.DARK_BLUE_COLOR,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: const Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
