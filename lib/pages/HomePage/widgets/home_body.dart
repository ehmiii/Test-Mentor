import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testmentor/controllers/home_controller.dart';
import 'package:testmentor/utils/widgets/show_toast.dart';

import '../../../models/category_model.dart';
import '../../../utils/Routes/routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/data/categories_names.dart';

class HomeBody extends StatelessWidget {
  final BoxConstraints constrains;
  const HomeBody({super.key, required this.constrains});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      List<CategoryModel> categories = homeController.getAvailabelCategory;
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
                  await homeController
                      .getMcqsFromDataBase(categories[index].categoryName);
                  Get.toNamed(Routes.getMcqsLengthSelectionPage());
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
