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
  final List<CategoryModel> categories;
  final String subject;
  final String? isTest;
  const HomeBody({
    super.key,
    required this.constrains,
    required this.categories,
    required this.subject,
    this.isTest,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 25.0,
          mainAxisSpacing: 25.0,
          mainAxisExtent: constrains.maxWidth * 0.35,
        ),
        itemBuilder: (_, index) => Container(
          decoration: BoxDecoration(
            color: Constants.DARK_BLUE_COLOR.withOpacity(.2),
            border: Border.all(color: Constants.DARK_BLUE_COLOR),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            image: DecorationImage(
              image: AssetImage(categories[index].categoryImage),
              fit: BoxFit.cover,
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
              onTap: () async {
                try {
                  homeController.setSelectedCategory =
                      categories[index].categoryName;
                  // Get.toNamed(Routes.getMcqsLengthSelectionPage());
                  if (isTest != 'test') {
                    Get.toNamed(Routes.getMcqsPage());
                    if (subject == "Computer Science") {
                      await homeController.getMcqsFromDataBase(
                          "Computer Science", categories[index].categoryName);
                    } else {
                      await homeController.getMcqsFromDataBase(
                          "English", categories[index].categoryName);
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          TestMcqsSelectionDialog.TEST_MCQS_SELECTION_DIALOG(
                              context),
                      barrierDismissible: false,
                      barrierLabel: "Select Length of Mcqs",
                      barrierColor: Constants.DARK_BLUE_COLOR.withOpacity(.7),
                    );
                    if (subject == "Computer Science") {
                      await homeController.getMcqsFromDataBase(
                          "Computer Science", categories[index].categoryName);
                    } else {
                      await homeController.getMcqsFromDataBase(
                          "English", categories[index].categoryName);
                    }
                  }
                } catch (error) {
                  ShowToast.SHOW_TOAST(error.toString());
                }
              },
              child: Container(
                width: constrains.maxWidth * 0.3,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Constants.DARK_BLUE_COLOR),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Container(
                  height: constrains.maxHeight * .025,
                  width: constrains.maxWidth * .37,
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Constants.DARK_BLUE_COLOR.withOpacity(.4),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      categories[index].categoryName,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        itemCount: categories.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
      );
    });
  }
}
