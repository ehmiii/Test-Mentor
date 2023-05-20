import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import '/controllers/add_mcqs_controller.dart';
import '/controllers/home_controller.dart';
import '/utils/constants.dart';
import '/utils/widgets/show_toast.dart';

class AddMcqsPage extends StatefulWidget {
  const AddMcqsPage({super.key});

  @override
  State<AddMcqsPage> createState() => _AddMcqsPageState();
}

class _AddMcqsPageState extends State<AddMcqsPage> {
  bool check = false;

  AddMcqsController addMcqsController = Get.find<AddMcqsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.LIGHT_BLUE_COLOR,
      appBar: AppBar(
        backgroundColor: Constants.DARK_BLUE_COLOR,
        leading: TextButton(
          child: FittedBox(
            child: Text(
              "Discard",
              style: TextStyle(color: Constants.LIGHT_BLUE_COLOR, fontSize: 40),
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Add Mcqs",
            style: TextStyle(color: Constants.LIGHT_BLUE_COLOR)),
        centerTitle: true,
        actions: [
          Obx(
            () => addMcqsController.getIsLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Constants.LIGHT_BLUE_COLOR,
                    ),
                  )
                : TextButton(
                    child: FittedBox(
                      child: Text(
                        "POST",
                        style: TextStyle(
                            color: Constants.LIGHT_BLUE_COLOR, fontSize: 16),
                      ),
                    ),
                    onPressed: () async {
                      await addMcqsController.addMcqs();
                    },
                  ),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * .07,
              ),
              child: Form(
                key: addMcqsController.getTextFormGlobalKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        minLines: 4,
                        maxLines: 8,
                        controller: addMcqsController.getQuestionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter mcqs";
                          } else if (addMcqsController
                              .checkingQuestionDuplication()
                              .contains(value)) {
                            return "Given Mcqs exsist";
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
                                  fillColor:
                                      Constants.BLUE_COLOR.withOpacity(.8),
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
                                    color:
                                        Constants.DARK_BLUE_COLOR.withOpacity(
                                      .6,
                                    ),
                                  ),
                                  hintText:
                                      addMcqsController.getListHintText[index]),
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
                        child: Text(
                          Get.find<HomeController>()
                              .getUserInfo!
                              .specialization,
                          style: TextStyle(
                            color: Constants.DARK_BLUE_COLOR,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            if (addMcqsController.getRightAnswerController.text ==
                    addMcqsController.getWrongAnswer1Controller.text ||
                addMcqsController.getRightAnswerController.text ==
                    addMcqsController.getWrongAnswer2Controller.text ||
                addMcqsController.getRightAnswerController.text ==
                    addMcqsController.getWrongAnswer3Controller.text) {
              ShowToast.SHOW_TOAST(
                  "Please note that. Mcqs Question correct answer should be unique");
            }
            await addMcqsController.addMcqs();
            // ignore: empty_catches
          } catch (err) {}
        },
        tooltip: "Post Mcqs",
        child: Obx(
          () => addMcqsController.getIsLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Constants.LIGHT_BLUE_COLOR,
                  ),
                )
              : Icon(
                  Icons.add,
                  size: 40,
                  color: Constants.LIGHT_BLUE_COLOR,
                ),
        ),
      ),
    );
  }
}
