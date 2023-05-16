import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/pages/McqsLengthSelectionPage/McqsLengthSelectionPage.dart';
import '/utils/constants.dart';

class SubCategoryPage extends StatelessWidget {
  const SubCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Constants.LIGHT_BLUE_COLOR,
          ),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
      ),
      body: LayoutBuilder(builder: (context, constrains) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Constants.LIGHT_BLUE_COLOR),
          child: ListView.builder(
            itemBuilder: (context, index) => Container(
              width: constrains.maxWidth * .4,
              height: 90,
              margin: const EdgeInsets.only(bottom: 8, right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15,
                ),
                gradient: LinearGradient(
                  colors: [
                    Constants.BLUE_COLOR,
                    Constants.LIGHT_BLUE_COLOR,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(.3),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: constrains.maxWidth * .02,
                      ),
                      Container(
                        width: 70,
                        height: 70,
                        // padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // border: Border.all(
                          //   color: Constants.APP_COLORS[index % 5],
                          // ),
                          shape: BoxShape.circle,
                          color: Constants.BLUE_COLOR,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2, 1),
                              // blurRadius: 1,
                              color: Colors.black.withOpacity(
                                .5,
                              ),
                            ),
                          ],
                          // image: DecorationImage(
                          //   image: AssetImage(
                          //     Constants.LIGHT_BACKGROUN_LOGO,
                          //   ),
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                        child: ClipOval(
                            child: SvgPicture.asset(
                          Constants.DARK_BACKGROUN_LOGO_SVG,
                        )
                            // child: Image.asset(
                            //   Constants.DARK_BACKGROUN_LOGO,
                            //   fit: BoxFit.fill,
                            // ),
                            ),
                      ),
                      SizedBox(
                        width: constrains.maxWidth * .02,
                      ),
                      Text(
                        "Analogy $index",
                      ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    child: InkWell(
                      splashColor: Constants.DARK_BLUE_COLOR,
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => McqsLengthSelectionPage(),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            itemCount: 20,
          ),
        );
      }),
    );
  }
}
