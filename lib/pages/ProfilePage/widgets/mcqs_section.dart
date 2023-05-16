import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '/controllers/home_controller.dart';

import '../../../utils/Routes/routes.dart';
import '../../../utils/constants.dart';

class McqsSection extends StatelessWidget {
  final BoxConstraints constrains;
  const McqsSection({super.key, required this.constrains});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Your Posted MCQs",
          style: TextStyle(
            color: Constants.DARK_BLACK_COLOR,
            fontSize: 15,
          ),
        ),
        GetBuilder<HomeController>(builder: (homeController) {
          return FutureBuilder(
              future: homeController.getSpecialistMcqs.isEmpty
                  ? homeController.getSpecialistPostedMcqs()
                  : null,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Container(
                        constraints: BoxConstraints(
                          maxHeight: constrains.maxHeight * .47,
                          minHeight: constrains.maxHeight * .47,
                          maxWidth: constrains.maxWidth,
                          minWidth: constrains.maxWidth,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          itemCount: homeController.getSpecialistMcqs.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, index) {
                            return homeController.getIsEditingEnable
                                ? Slidable(
                                    // direction: Axis.horizontal,
                                    // enabled: true,
                                    endActionPane: ActionPane(
                                      extentRatio: .15,
                                      motion: const ScrollMotion(),
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await homeController
                                                .deleteNotification(
                                                    homeController
                                                            .getSpecialistMcqs[
                                                        index]);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 40,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                        color: Constants.DARK_BLUE_COLOR,
                                        child: ExpansionTileTheme(
                                          data: ExpansionTileThemeData(
                                            iconColor:
                                                Constants.LIGHT_BLUE_COLOR,
                                            collapsedIconColor:
                                                Constants.LIGHT_BLUE_COLOR,
                                            collapsedTextColor:
                                                Constants.LIGHT_BLUE_COLOR,
                                            textColor:
                                                Constants.LIGHT_BLUE_COLOR,
                                          ),
                                          child: ExpansionTile(
                                            title: Text(
                                              "Question ${index + 1} :${homeController.getSpecialistMcqs[index].question}",
                                              style: TextStyle(
                                                color:
                                                    Constants.LIGHT_BLUE_COLOR,
                                              ),
                                            ),
                                            leading: IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                              ),
                                              onPressed: () {
                                                Get.offAndToNamed(
                                                  Routes.getAddMcqsPage(),
                                                  arguments: [
                                                    homeController
                                                            .getSpecialistMcqs[
                                                        index],
                                                    true
                                                  ],
                                                );
                                              },
                                            ),
                                            expandedCrossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Subject: ${homeController.getSpecialistMcqs[index].category}",
                                                style: TextStyle(
                                                  color: Constants
                                                      .LIGHT_BLUE_COLOR,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        // child: ListTile(
                                        //   leading: IconButton(
                                        //     onPressed: () {},
                                        //     icon: Icon(
                                        //       Icons.edit,
                                        //       color: Constants.DARK_BLUE_COLOR,
                                        //     ),
                                        //   ),
                                        //   title: ,
                                        // ),
                                        ),
                                  )
                                : Card(
                                    color: Constants.DARK_BLUE_COLOR,
                                    child: ListTile(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => Dialog(
                                            backgroundColor:
                                                Constants.LIGHT_BLUE_COLOR,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    "Question ${index + 1} :${homeController.getSpecialistMcqs[index].question}",
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      color: Constants
                                                          .DARK_BLUE_COLOR,
                                                    ),
                                                  ),
                                                  AutoSizeText(
                                                    homeController
                                                        .getSpecialistMcqs[
                                                            index]
                                                        .wrongAnswer1,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      color: Constants
                                                          .DARK_BLUE_COLOR,
                                                    ),
                                                  ),
                                                  AutoSizeText(
                                                    homeController
                                                        .getSpecialistMcqs[
                                                            index]
                                                        .wrongAnswer2,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      color: Constants
                                                          .DARK_BLUE_COLOR,
                                                    ),
                                                  ),
                                                  AutoSizeText(
                                                    homeController
                                                        .getSpecialistMcqs[
                                                            index]
                                                        .wrongAnswer3,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      color: Constants
                                                          .DARK_BLUE_COLOR,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Constants
                                                            .DARK_BLACK_COLOR,
                                                      ),
                                                    ),
                                                    child: AutoSizeText(
                                                      homeController
                                                          .getSpecialistMcqs[
                                                              index]
                                                          .rightAnswer,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                        color: Constants
                                                            .DARK_BLUE_COLOR,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      title: AutoSizeText(
                                        "Question ${index + 1} :${homeController.getSpecialistMcqs[index].question}",
                                        maxLines: 3,
                                        style: TextStyle(
                                          color: Constants.LIGHT_BLUE_COLOR,
                                        ),
                                      ),
                                    ));
                          },
                        ),
                      );
              });
        })
        // Container(
        //   margin: EdgeInsets.symmetric(
        //     horizontal: constrains.maxWidth * .02,
        //   ),
        //   padding: EdgeInsets.symmetric(vertical: constrains.maxWidth * .01),
        //   height: constrains.maxHeight * .40,
        //   alignment: Alignment.centerLeft,
        //   decoration: BoxDecoration(
        //     color: Constants.DARK_GRAY_COLOR,
        //     borderRadius: BorderRadius.circular(
        //       15,
        //     ),
        //   ),
        //   child: ListView.builder(
        //     itemCount: 3,
        //     itemBuilder: (context, index) => Container(
        //       margin: EdgeInsets.symmetric(
        //         horizontal: constrains.maxWidth * 0.03,
        //         vertical: constrains.maxWidth * .02,
        //       ),
        //       padding: EdgeInsets.all(constrains.maxWidth * 0.01),
        //       height: constrains.maxHeight * .2,
        //       decoration: BoxDecoration(
        //         color: Constants.LIGHT_BLUE_COLOR,
        //         borderRadius: BorderRadius.circular(
        //           5,
        //         ),
        //       ),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             "DART",
        //             style: TextStyle(
        //               color: Constants.DARK_BLACK_COLOR,
        //               fontSize: 15,
        //             ),
        //           ),
        //           SizedBox(
        //             width: constrains.maxWidth,
        //             height: 100,
        //             child: GridView.builder(
        //               // physics: NeverScrollableScrollPhysics(),
        //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                 crossAxisCount: 2,
        //                 crossAxisSpacing: 5.0,
        //                 mainAxisSpacing: 6.0,
        //                 mainAxisExtent: constrains.maxWidth * 0.3,
        //               ),
        //               itemBuilder: (_, index) => Container(
        //                 width: constrains.maxWidth * 0.3,
        //                 padding: const EdgeInsets.all(4),
        //                 decoration: BoxDecoration(
        //                   color: Constants.DARK_GRAY_COLOR,
        //                   borderRadius: BorderRadius.circular(50),
        //                 ),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                   children: [
        //                     Expanded(
        //                       child: FittedBox(
        //                         child: Text(
        //                           "MCQs $index",
        //                           style: TextStyle(
        //                               fontSize: 12,
        //                               color: Constants.LIGHT_BLUE_COLOR),
        //                         ),
        //                       ),
        //                     ),
        //                     SizedBox(
        //                       height: 30,
        //                       width: 30,
        //                       child: Image.asset(
        //                         Constants.MCQS_FORWARD_ICON,
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //               ),
        //               itemCount: 50,
        //               shrinkWrap: true,
        //               scrollDirection: Axis.horizontal,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
