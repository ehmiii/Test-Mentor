// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/categories_names.dart';
import '/controllers/signup_controller.dart';

import '../../../utils/constants.dart';
import 'show_toast.dart';

class CategorySelectionDialog {
  static Widget CATEGORY_BUTTON({
    required String cateGoryName,
    required VoidCallback press,
    required bool isSelected,
  }) {
    final textButtonStyle = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
    );

    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isSelected
                ? Constants.BLUE_COLOR.withOpacity(.7)
                : Constants.BLUE_COLOR,
            isSelected
                ? Constants.LIGHT_BLUE_COLOR.withOpacity(.7)
                : Constants.LIGHT_BLUE_COLOR,
          ],
          // begin: Alignment.bottomRight,
          // end: Alignment.topLeft,
        ),
        boxShadow: [
          BoxShadow(
            color: Constants.DARK_BLUE_COLOR.withOpacity(.5),
            offset: const Offset(2, 4),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: TextButton(
        onPressed: press,
        style: textButtonStyle,
        child: Text(
          cateGoryName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  static Dialog CATEGORY_SELECTION_DIALOG(BuildContext context) {
    final textButtonStyle = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
    );
    SignUpController signUpController = Get.find<SignUpController>();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      //this right here
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 22,
              right: 22,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Constants.BLUE_COLOR,
                  Constants.LIGHT_BLUE_COLOR,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              border: Border.all(
                color: Constants.DARK_BLUE_COLOR,
              ),
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: CategoriesName.CATEGORIES_NAME
                    .map(
                      (categoryName) => Obx(
                        () => CATEGORY_BUTTON(
                          isSelected: signUpController.getSeletedCategories
                              .contains(categoryName.categoryName),
                          cateGoryName: categoryName.categoryName,
                          press: () {
                            print(signUpController.getSeletedCategories.length);
                            if (signUpController.getSeletedCategories.length <
                                    3 ||
                                signUpController.getSeletedCategories
                                    .contains(categoryName.categoryName)) {
                              signUpController.setSelectedCategories =
                                  categoryName.categoryName;
                            } else {
                              ShowToast.SHOW_TOAST(
                                  "Maximum 3 Subject selection are allowed");
                            }
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Positioned(
            top: -8,
            right: -8,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).maybePop();
              },
              child: SizedBox(
                height: 50,
                width: 50,
                child: ClipOval(
                  child: Image.asset(
                    Constants.CLOSE_ICON,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
