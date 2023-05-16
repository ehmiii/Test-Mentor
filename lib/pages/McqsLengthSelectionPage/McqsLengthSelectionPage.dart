import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import '/controllers/home_controller.dart';

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
      body: GetBuilder<HomeController>(
        builder: (homeController) {
          return homeController.getIsLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 0),
                      // color: Colors.amber,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * .85,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => index % 10 != 0
                            ? const SizedBox()
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
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0,
                          ),
                          child: Text(
                            "Total Mcqs: ${homeController.getMcqs.length}",
                            style: TextStyle(
                              fontSize: 20,
                              color: Constants.DARK_BLUE_COLOR,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
