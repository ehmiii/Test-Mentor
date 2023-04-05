import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:testmentor/controllers/home_controller.dart';

import '../../utils/constants.dart';
import '../../utils/widgets/custom_appbar.dart';
import '../McqsPage/mcqs_page.dart';

class McqsLengthSelectionPage extends StatelessWidget {
  const McqsLengthSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.CUSTOM_APPBAR(context: context),
      backgroundColor: Constants.LIGHT_BLUE_COLOR,
      body: GetBuilder<HomeController>(builder: (homeController) {
        return Container(
          padding: const EdgeInsets.only(top: 0),
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => index % 50 != 0
                ? SizedBox()
                : Container(
                    height: 80,
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: index == 29 ? 10 : 0,
                      right: 16,
                      left: 16,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Constants.BLUE_COLOR,
                          Constants.LIGHT_BLUE_COLOR,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          blurRadius: 2,
                          offset: const Offset(
                            2,
                            2,
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          "Mcqs ${index + 1} - ${index + 50}",
                          style: TextStyle(
                            fontSize: 25,
                            color: Constants.DARK_BLUE_COLOR,
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                          child: InkWell(
                            splashColor: Constants.DARK_BLUE_COLOR,
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => McqsPage(),
                                ),
                              );
                            },
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            itemCount: homeController.getMcqs.length,
          ),
        );
      }),
    );
  }
}
