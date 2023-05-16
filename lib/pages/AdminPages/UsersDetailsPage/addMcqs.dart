import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import '/controllers/add_mcqs_controller.dart';
import '/controllers/admin_controller.dart';
import '/utils/widgets/category_selection_dialog.dart';

import '../../../utils/constants.dart';
import '../../../utils/data/categories_names.dart';

class AddMcqsByAdmin extends StatelessWidget {
  const AddMcqsByAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(builder: (addMcqsController) {
      return SingleChildScrollView(
        child: Form(
          key: addMcqsController.getTextFormGlobalKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  minLines: 4,
                  maxLines: 8,
                  controller: addMcqsController.getQuestionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter mcqs";
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                    fontSize: 18,
                    color: Constants.DARK_BLUE_COLOR,
                  ),
                  decoration: InputDecoration(
                    hintText: "Write MCQs Here/Past",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Constants.DARK_BLUE_COLOR.withOpacity(.6),
                    ),
                    filled: true,
                    fillColor: Constants.BLUE_COLOR.withOpacity(.8),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Constants.DARK_BLUE_COLOR,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      child: TextFormField(
                        cursorHeight: 20,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please fill the option";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                          color: Constants.DARK_BLUE_COLOR,
                          fontSize: 18,
                        ),
                        controller:
                            addMcqsController.getAddMcqsController[index],
                        cursorColor: Constants.DARK_BLUE_COLOR,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Constants.BLUE_COLOR.withOpacity(.8),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Constants.DARK_BLUE_COLOR,
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Constants.DARK_BLUE_COLOR.withOpacity(
                                .6,
                              ),
                            ),
                            hintText: addMcqsController.getListHintText[index]),
                      ),
                    );
                  },
                ),
                Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      border: Border.all(
                        color: Constants.DARK_BLUE_COLOR,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Constants.BLUE_COLOR,
                          Constants.LIGHT_BLUE_COLOR,
                        ],
                      ),
                    ),
                    child: SizedBox(
                      child: DropdownButton(
                        dropdownColor: Constants.LIGHT_BLUE_COLOR,
                        isExpanded: true,
                        value:
                            addMcqsController.getSelectedSpecialization.isEmpty
                                ? "Select Specialization"
                                : addMcqsController.getSelectedSpecialization,
                        items: CategoriesName.CATEGORIES_NAME
                            .map(
                              (categoryDetail) => DropdownMenuItem(
                                value: categoryDetail.categoryName,
                                child: Text(
                                  categoryDetail.categoryName,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          addMcqsController.setSelectedSpecialization =
                              value ?? "";
                        },
                      ),
                    )
                    // child: TextButton(
                    //   onPressed: () {

                    //   },
                    //   child: Text(
                    //     addMcqsController.getUserInformation.specialization,
                    //     style: TextStyle(
                    //       color: Constants.DARK_BLUE_COLOR,
                    //       fontSize: 20,
                    //     ),
                    //   ),
                    // ),
                    ),
                ElevatedButton(
                  onPressed: () {
                    addMcqsController.addMcqs();
                  },
                  child: const Text(
                    "Add Mcqs",
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
