import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:testmentor/utils/constants.dart';

class Mcqs extends StatefulWidget {
  final String question;
  final String wrongAnswer1;
  final String wrongAnswer2;
  final String wrongAnswer3;
  final String rightAnswer;
  Mcqs({
    super.key,
    required this.question,
    required this.wrongAnswer1,
    required this.wrongAnswer2,
    required this.wrongAnswer3,
    required this.rightAnswer,
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
      widget.wrongAnswer1,
      widget.wrongAnswer2,
      widget.wrongAnswer3,
      widget.rightAnswer,
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
          widget.question,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < answers.length; i++)
              isAnswerButtonClicked && answers[i] == widget.rightAnswer
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
                        "${sequence[i]} ${widget.rightAnswer}",
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
                "Answer",
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
              onPressed: () {},
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
