import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:testmentor/pages/ProfilePage/profile_page.dart';
import 'package:testmentor/pages/SubCategoryPage/sub_category_page.dart';
import 'package:testmentor/utils/constants.dart';

import '../SettingPage/setting_page.dart';

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
      drawer: SafeArea(
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
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
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
                  child: Image.asset(
                    Constants.DARK_BACKGROUN_LOGO,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.person,
                  ),
                  title: const Text(
                    "Ahmad Khan",
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.email_outlined,
                  ),
                  title: const Text(
                    "ahmad@gmail.com",
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => HomePage(),
                      ),
                    );
                  },
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                ),
                const SizedBox(
                  height: 8,
                ),
                ListTile(
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
                  height: 8,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SettingPage(),
                      ),
                    );
                  },
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                ),
                const SizedBox(
                  height: 8,
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.star_rate_rounded,
                  ),
                  title: const Text('Rate Us'),
                ),
                const SizedBox(
                  height: 8,
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.details_rounded,
                  ),
                  title: const Text('About Us'),
                ),
                const SizedBox(
                  height: 8,
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
      ),
      child: Scaffold(
        appBar: Constants.CUSTOM_APPBAR(
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
        body: LayoutBuilder(
          builder: (context, constrains) => Container(
            width: constrains.maxWidth,
            padding: EdgeInsets.all(constrains.maxWidth * 0.01),
            decoration: BoxDecoration(
              color: Constants.LIGHT_BLUE_COLOR,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent",
                    style: TextStyle(
                      color: Constants.DARK_BLUE_COLOR,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(constrains.maxWidth * 0.01),
                    child: Column(
                      children: [
                        SizedBox(
                          height: constrains.maxWidth * .27,
                          child: ListView.builder(
                            itemExtent: constrains.maxWidth * 0.19,
                            itemCount: 5,
                            itemBuilder: (context, index) => Column(
                              children: [
                                Container(
                                  height: constrains.maxWidth * .17,
                                  width: constrains.maxWidth * .17,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: Constants.APP_COLORS[index % 5],
                                    ),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                          "assets/images/newsImage.jpeg",
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                  // child: Image.asset(
                                  //   Constants.LIGHT_BACKGROUN_LOGO,
                                  //   fit: BoxFit.fill,
                                  // ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Xyz",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Constants.APP_COLORS[index % 5],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        SizedBox(
                          width: constrains.maxWidth,
                          height: constrains.maxHeight * .075,
                          child: Material(
                            color: Constants.BLUE_COLOR,
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                              splashColor: Constants.DARK_BLACK_COLOR,
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Constants.DARK_BLUE_COLOR,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add MCQs",
                                  style: TextStyle(
                                    color: Constants.DARK_BLACK_COLOR,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 25.0,
                      mainAxisSpacing: 25.0,
                      mainAxisExtent: constrains.maxWidth * 0.35,
                    ),
                    itemBuilder: (_, index) => Container(
                      decoration: BoxDecoration(
                        // color: Colors.transparent,
                        border: Border.all(color: Constants.DARK_BLUE_COLOR),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        image: const DecorationImage(
                          image: AssetImage(
                            "assets/images/newsImage.jpeg",
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        child: InkWell(
                          splashColor: Constants.DARK_BLUE_COLOR,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SubCategoryPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: constrains.maxWidth * 0.3,
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border:
                                  Border.all(color: Constants.DARK_BLUE_COLOR),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                              // image: const DecorationImage(
                              //   image: AssetImage(
                              //     "assets/images/newsImage.jpeg",
                              //   ),
                              //   fit: BoxFit.fill,
                              // ),
                            ),
                            child: Container(
                              height: constrains.maxHeight * .03,
                              width: constrains.maxWidth * .3,
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    Constants.LIGHT_BLUE_COLOR.withOpacity(.5),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: FittedBox(
                                child: Text(
                                  "New HeadLine $index",
                                  style: TextStyle(
                                      color: Constants.DARK_BLACK_COLOR,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: 50,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
