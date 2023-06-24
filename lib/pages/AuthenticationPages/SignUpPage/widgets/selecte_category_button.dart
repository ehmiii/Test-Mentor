import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../../controllers/signup_controller.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/widgets/category_selection_dialog.dart';

class SelectCategoryButton extends StatelessWidget {
  final String category;
  const SelectCategoryButton({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 30,
      ),
      child: Material(
        color: Constants.LIGHT_BLUE_COLOR,
        borderRadius: BorderRadius.circular(
          15,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(
            15,
          ),
          splashColor: Constants.DARK_BLUE_COLOR,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) =>
                  CategorySelectionDialog.CATEGORY_SELECTION_DIALOG(context),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            child: Text(
              category,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                color: Constants.DARK_BLUE_COLOR,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
