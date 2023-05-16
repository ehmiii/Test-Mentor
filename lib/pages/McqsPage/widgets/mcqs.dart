import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import '/controllers/home_controller.dart';
import '/models/mcqs_model.dart';
import '/utils/constants.dart';

class Mcqs extends StatefulWidget {
  final McqsModel mcqs;
  const Mcqs({
    super.key,
    required this.mcqs,
  });

  @override
  State<Mcqs> createState() => _McqsState();
}

class _McqsState extends State<Mcqs> {
  bool isAnswerButtonClicked = false;
  List<String> answers = [];
  @override
  initState() {
    answers = [
      widget.mcqs.wrongAnswer1,
      widget.mcqs.wrongAnswer2,
      widget.mcqs.wrongAnswer3,
      widget.mcqs.rightAnswer,
    ];
    answers.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> sequence = ["A)", "B)", "C)", "D)"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.mcqs.question,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < answers.length; i++)
              isAnswerButtonClicked && answers[i] == widget.mcqs.rightAnswer
                  ? Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Constants.DARK_BLUE_COLOR,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "${sequence[i]} ${widget.mcqs.rightAnswer}",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  : Text(
                      "${sequence[i]} ${answers[i]}",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  isAnswerButtonClicked = !isAnswerButtonClicked;
                });
              },
              child: const Text(
                "Click for answer",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            TextButton.icon(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.zero,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierColor: Constants.DARK_BLUE_COLOR.withOpacity(.7),
                  barrierDismissible: false,
                  builder: (_) {
                    return Dialog(
                      backgroundColor: Constants.LIGHT_BLUE_COLOR,
                      child: GetBuilder<HomeController>(
                        builder: (homeController) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .75,
                                height: 50,
                                child: CheckboxListTile(
                                  // contentPadding: EdgeInsets.zero,
                                  value:
                                      homeController.getQuestionErrorSelected,
                                  onChanged: (value) {
                                    homeController.setQuestionErrorSelected =
                                        !homeController
                                            .getQuestionErrorSelected;
                                    homeController.update();
                                  },
                                  activeColor: Constants.DARK_BLUE_COLOR,
                                  side: BorderSide(
                                    color: Constants.DARK_BLUE_COLOR,
                                  ),
                                  title: FittedBox(
                                    child: Text(
                                      "Question (Error/Spell Mistake)",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Constants.DARK_BLUE_COLOR,
                                      ),
                                    ),
                                  ),
                                  // fillColor: MaterialStateProperty.all(
                                  //   Constants.DARK_BLUE_COLOR,
                                  // ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .75,
                                height: 50,
                                child: CheckboxListTile(
                                  // contentPadding: EdgeInsets.zero,
                                  value: homeController.getOptionErrorSelected,
                                  onChanged: (value) {
                                    homeController.setOptionErrorSelected =
                                        !homeController.getOptionErrorSelected;
                                    homeController.update();
                                  },
                                  activeColor: Constants.DARK_BLUE_COLOR,
                                  side: BorderSide(
                                    color: Constants.DARK_BLUE_COLOR,
                                  ),
                                  title: FittedBox(
                                    child: Text(
                                      "Options (Error/Spell Mistake)",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Constants.DARK_BLUE_COLOR,
                                      ),
                                    ),
                                  ),
                                  // fillColor: MaterialStateProperty.all(
                                  //   Constants.DARK_BLUE_COLOR,
                                  // ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 13.0,
                                ),
                                child: TextFormField(
                                  controller:
                                      homeController.getMcqsCommentController,
                                  decoration: InputDecoration(
                                    hintText: "Any Comments",
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Constants.DARK_BLUE_COLOR.withOpacity(
                                        .5,
                                      ),
                                    ),
                                    labelText: "Comment",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        8,
                                      ),
                                      borderSide: BorderSide(
                                        color: Constants.DARK_BLUE_COLOR,
                                      ),
                                    ),
                                  ),
                                  maxLength: 100,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      Navigator.maybePop(context);
                                      await homeController
                                          .userReport(widget.mcqs);
                                      homeController.setQuestionErrorSelected =
                                          false;
                                      homeController.setOptionErrorSelected =
                                          false;
                                      homeController
                                          .getMcqsCommentController.text = "";
                                    },
                                    child: const Text(
                                      "Submit Report",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                    ),
                                    child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          splashColor:
                                              Constants.DARK_BLUE_COLOR,
                                          onTap: () {
                                            homeController
                                                    .setQuestionErrorSelected =
                                                false;
                                            homeController
                                                .setOptionErrorSelected = false;
                                            homeController
                                                .getMcqsCommentController
                                                .text = "";
                                            Navigator.maybePop(context);
                                          },
                                          child: SizedBox(
                                            height: 40,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Close",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Constants
                                                        .DARK_BLUE_COLOR,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.close,
                                                  color:
                                                      Constants.DARK_BLUE_COLOR,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.report,
              ),
              label: const Text(
                "Report",
              ),
            )
          ],
        ),
      ],
    );
  }
}
