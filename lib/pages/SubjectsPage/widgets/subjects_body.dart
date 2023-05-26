import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/test_controller.dart';
import '../../McqsPage/widgets/test_mcqs_selection_dialog.dart';
import '/controllers/home_controller.dart';
import '/utils/widgets/show_toast.dart';

import '../../../models/category_model.dart';
import '../../../utils/Routes/routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/data/categories_names.dart';

class HomeBody extends StatelessWidget {
  final BoxConstraints constrains;
  const HomeBody({
    super.key,
    required this.constrains,
  });
  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = [];
    print(Get.find<HomeController>().getUserSelectedSubjectTitle);
    if (Get.find<HomeController>().getUserSelectedSubjectTitle ==
        "Computer Science") {
      List<CategoryModel> categories = [];
      for (var category in Get.find<HomeController>().getAvailabelCategory) {
        print(category);
        if (CategoriesName.COMPUTER_SCIENCE.contains(category)) {
          print(category.categoryName);
          categories.add(category);
        }
      }
      return categories;
    } else {
      for (var category in Get.find<HomeController>().getAvailabelCategory) {
        if (!CategoriesName.COMPUTER_SCIENCE.contains(category)) {
          categories.add(category);
        }
      }
      return categories;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: getCategories(),
      builder: (context, categories) => Visibility(
        visible: categories.connectionState != ConnectionState.waiting,
        replacement: const Center(child: CircularProgressIndicator.adaptive()),
        child: GetBuilder<HomeController>(builder: (homeController) {
          return categories.data!.isEmpty
              ? const Center(
                  child: Text(
                      "Currently Subjects not available. Soon it will be added"),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 25.0,
                      mainAxisSpacing: 25.0,
                      mainAxisExtent: constrains.maxWidth * 0.35,
                    ),
                    itemBuilder: (_, index) => Container(
                      decoration: BoxDecoration(
                        color: Constants.BLUE_COLOR,
                        // border: Border.all(color: Constants.DARK_BLUE_COLOR),
                        borderRadius: BorderRadius.circular(25),
                        // gradient: RadialGradient(colors: [
                        //   Constants.DARK_BLUE_COLOR.withOpacity(.6),
                        //   Constants.BLUE_COLOR,
                        //   Constants.BLUE_COLOR,
                        //   Constants.BLUE_COLOR,
                        //   Constants.BLUE_COLOR,
                        //   Constants.BLUE_COLOR,
                        //   Constants.BLUE_COLOR,
                        //   Constants.BLUE_COLOR,
                        //   Constants.BLUE_COLOR,
                        //   Constants.BLUE_COLOR,
                        //   Constants.BLUE_COLOR,
                        //   Constants.BLUE_COLOR,
                        // ])
                        // image: DecorationImage(
                        //   image:
                        //       AssetImage(categories.data![index].categoryImage),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        // borderRadius: const BorderRadius.only(
                        //   topLeft: Radius.circular(25),
                        //   bottomRight: Radius.circular(25),
                        // ),
                        child: InkWell(
                          splashColor: Constants.DARK_BLUE_COLOR,
                          borderRadius: BorderRadius.circular(25),
                          onTap: () async {
                            try {
                              homeController.setSelectedCategory =
                                  categories.data![index].categoryName;
                              // Get.toNamed(Routes.getMcqsLengthSelectionPage());

                              if (homeController.getUserChoice != 'Test') {
                                Get.toNamed(Routes.getMcqsPage());
                                // if (homeController.getUserSelectedSubjectTitle == "Computer Science") {
                                //   await homeController.getMcqsFromDataBase(
                                //       "Computer Science", categories.data![index].categoryName);
                                // } else {
                                //   await homeController.getMcqsFromDataBase(
                                //       "English", categories.data![index].categoryName);
                                // }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      TestMcqsSelectionDialog
                                          .TEST_MCQS_SELECTION_DIALOG(context),
                                  barrierDismissible: false,
                                  barrierLabel: "Select Length of Mcqs",
                                  barrierColor:
                                      Constants.DARK_BLUE_COLOR.withOpacity(.7),
                                );
                                // if (subject == "Computer Science") {
                                //   await homeController.getMcqsFromDataBase(
                                //       "Computer Science", categories.data![index].categoryName);
                                // } else {
                                //   await homeController.getMcqsFromDataBase(
                                //       "English", categories[index].categoryName);
                                // }
                              }
                              await homeController.getMcqsFromDataBase(
                                  homeController.getUserSelectedSubjectTitle,
                                  categories.data![index].categoryName);
                            } catch (error) {
                              ShowToast.SHOW_TOAST(error.toString());
                            }
                          },
                          child: Container(
                            width: constrains.maxWidth * 0.3,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              // border:
                              // Border.all(color: Constants.DARK_BLUE_COLOR),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            // child: Container(
                            //   height: constrains.maxHeight * .025,
                            //   width: constrains.maxWidth * .37,
                            //   padding: const EdgeInsets.symmetric(vertical: 2),
                            //   alignment: Alignment.center,
                            //   decoration: BoxDecoration(
                            //     color: Constants.DARK_BLUE_COLOR.withOpacity(.4),
                            //     borderRadius: const BorderRadius.only(
                            //       topLeft: Radius.circular(15),
                            //       topRight: Radius.circular(15),
                            //     ),
                            //   ),
                            child: Text(
                              categories.data![index].categoryName
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants.LIGHT_BLUE_COLOR,
                                fontSize: 20,
                              ),
                            ),
                            // ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: categories.data!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  ),
                );
        }),
      ),
    );
  }
}
