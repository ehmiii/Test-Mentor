import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import '/controllers/home_controller.dart';
import '/utils/Routes/routes.dart';
import '/utils/constants.dart';
import '/utils/widgets/custom_appbar.dart';

import '../../models/category_model.dart';
import '../../utils/data/categories_names.dart';

class SubjectsSelectionPage extends StatelessWidget {
  SubjectsSelectionPage({super.key});

  Future<List<String>> getAvilableSubjects(
      List<CategoryModel> categories) async {
    List<String> availableSubjects = [];
    for (var category in categories) {
      if (!CategoriesName.COMPUTER_SCIENCE.contains(category)) {
        if (!availableSubjects.contains("Computer Science")) {
          availableSubjects.add("Computer Science");
        }
      } else if (!CategoriesName.ENGLISH.contains(category)) {
        if (!availableSubjects.contains("English")) {
          availableSubjects.add("English");
        }
      }
    }
    availableSubjects.sort((a, b) => a.toString().compareTo(b.toString()));
    return availableSubjects;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return GetBuilder<HomeController>(builder: (homeController) {
        return FutureBuilder<List<String>>(
            future: getAvilableSubjects(homeController.getAvailabelCategory),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Scaffold(
                      backgroundColor: Constants.LIGHT_BLUE_COLOR,
                      appBar: CustomAppBar.CUSTOM_APPBAR(
                        context: context,
                      ),
                      body: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Card(
                          color: Constants.DARK_BLUE_COLOR,
                          child: ListTile(
                            onTap: () async {
                              if (snapshot.data![index] == "Computer Science") {
                                List<CategoryModel> categories = [];
                                for (var category
                                    in homeController.getAvailabelCategory) {
                                  if (CategoriesName.COMPUTER_SCIENCE
                                      .contains(category)) {
                                    categories.add(category);
                                  }
                                }
                                if (Get.arguments != null) {
                                  Get.toNamed(
                                    Routes.getSubjectsPage(),
                                    arguments: [
                                      categories,
                                      "Computer Science",
                                      "test"
                                    ],
                                  );
                                } else {
                                  Get.toNamed(
                                    Routes.getSubjectsPage(),
                                    arguments: [
                                      categories,
                                      "Computer Science",
                                      "preparation"
                                    ],
                                  );
                                }
                              } else {
                                List<CategoryModel> categories = [];
                                for (var category
                                    in homeController.getAvailabelCategory) {
                                  if (!CategoriesName.COMPUTER_SCIENCE
                                      .contains(category)) {
                                    categories.add(category);
                                  }
                                }
                                if (Get.arguments != null) {
                                  Get.toNamed(
                                    Routes.getSubjectsPage(),
                                    arguments: [
                                      categories,
                                      "English",
                                      "test",
                                    ],
                                  );
                                } else {
                                  Get.toNamed(
                                    Routes.getSubjectsPage(),
                                    arguments: [
                                      categories,
                                      "English",
                                      "prepartion",
                                    ],
                                  );
                                }
                              }
                            },
                            title: Text(
                              snapshot.data![index],
                              style: TextStyle(
                                color: Constants.LIGHT_BLUE_COLOR,
                                fontSize: 20,
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.asset(
                                  Constants.PREPARATION_MODE_ICON,
                                  color: Constants.LIGHT_BLUE_COLOR,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
            });
      });
    });
  }
}
