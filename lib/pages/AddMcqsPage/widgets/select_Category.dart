import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '/utils/constants.dart';

class Select_Category extends StatelessWidget {
  const Select_Category({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> selectcategory = [
      "Programing",
      "SQA",
      "Software Testing",
      "ULM Modeling",
      "Software Requirement"
    ];
    return Scaffold(
        backgroundColor: Constants.LIGHT_BLUE_COLOR,
        appBar: AppBar(
          title: Text(
            "Select Category",
            style: TextStyle(color: Constants.LIGHT_BLUE_COLOR),
          ),
          centerTitle: true,
          backgroundColor: Constants.DARK_BLUE_COLOR,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Container(
                height: constraints.maxHeight * .7,
                width: constraints.maxWidth * .9,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Container(
                        height: constraints.maxHeight * .1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Constants.DARK_BLUE_COLOR, width: 2),
                          gradient: LinearGradient(
                            colors: [
                              Constants.BLUE_COLOR,
                              Constants.LIGHT_BLUE_COLOR
                            ],
                          ),
                        ),
                        child: ListTile(
                          title: Center(
                            child: Text(selectcategory[index].toString()),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ));
  }
}
