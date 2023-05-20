import 'package:flutter/material.dart';
import 'package:gat_cs_trainer_app/utils/constants.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../models/category_model.dart';
import '../../utils/widgets/custom_appbar.dart';
import 'widgets/subjects_body.dart';

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});
  // final String title = Get.arguments[1];
  // final List<CategoryModel> categories = Get.arguments[0];
  // final String? test;

  // final String categories
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Scaffold(
          backgroundColor: Constants.LIGHT_BLUE_COLOR,
          appBar: CustomAppBar.CUSTOM_APPBAR(
            context: context,
            title: homeController.getUserSelectedSubjectTitle,
          ),
          body: homeController.getIsLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : LayoutBuilder(
                  builder: (context, constrains) => Container(
                    width: constrains.maxWidth,
                    padding: EdgeInsets.all(constrains.maxWidth * 0.01),
                    child: HomeBody(
                      constrains: constrains,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
