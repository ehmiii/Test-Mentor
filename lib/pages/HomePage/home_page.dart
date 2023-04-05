import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:testmentor/pages/ProfilePage/profile_page.dart';
import 'package:testmentor/pages/SubCategoryPage/sub_category_page.dart';
import 'package:testmentor/utils/Routes/routes.dart';
import 'package:testmentor/utils/constants.dart';

import '../../controllers/home_controller.dart';
import '../../utils/widgets/custom_appbar.dart';
import '../AddMcqsPage/add_mcqs_page.dart';
import 'widgets/custom_drawer.dart';
import '../SettingPage/setting_page.dart';
import 'widgets/home_body.dart';
import 'widgets/recents_viewed.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Constants.BLUE_COLOR,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      drawer: CustomDrawer.CUSTOM_DRAWER(context),
      child: Scaffold(
        appBar: CustomAppBar.CUSTOM_APPBAR(
          // isLeadingBack: false,
          context: context,
          title: "Home",
          icon: Icons.search,
          leadingButtonPressFunction: () {
            _advancedDrawerController.showDrawer();
          },
          leadingButtonIcon: Icons.menu,
        ),
        // drawer: const Drawer(),
        backgroundColor: Constants.LIGHT_BLUE_COLOR,
        body: GetBuilder<HomeController>(builder: (homeController) {
          return homeController.getIsLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : LayoutBuilder(
                  builder: (context, constrains) => Container(
                    width: constrains.maxWidth,
                    padding: EdgeInsets.all(constrains.maxWidth * 0.01),
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // RecentsViewed(
                          //   constrains: constrains,
                          // ),
                          Get.find<HomeController>().getUserInfo == null
                              ? const SizedBox()
                              : ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(
                                      Routes.getAddMcqsPage(),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Add Mcqs",
                                      style: TextStyle(
                                        color: Constants.LIGHT_BLUE_COLOR,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 5,
                          ),
                          HomeBody(
                            constrains: constrains,
                          )
                        ],
                      ),
                    ),
                  ),
                );
        }),
        floatingActionButton: Get.find<HomeController>().getUserInfo == null
            ? null
            : FloatingActionButton(
                onPressed: () {
                  Get.toNamed(
                    Routes.getAddMcqsPage(),
                  );
                },
                splashColor: Constants.LIGHT_BLUE_COLOR,
                backgroundColor: Constants.DARK_BLUE_COLOR,
                tooltip: "Add New Mcqs",
                child: Icon(
                  Icons.add,
                  color: Constants.LIGHT_BLUE_COLOR,
                  size: 35,
                ),
              ),
      ),
    );
  }
}
