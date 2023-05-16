// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:get/get.dart';

// import '../../../controllers/home_controller.dart';
// import '../../../utils/constants.dart';

// class RecentsViewed extends StatelessWidget {
//   final BoxConstraints constrains;
//   RecentsViewed({super.key, required this.constrains});
//   HomeController homeController = Get.find<HomeController>();
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Recent",
//           style: TextStyle(
//             color: Constants.DARK_BLUE_COLOR,
//             fontSize: 18,
//           ),
//         ),
//         homeController.getRecentViewed == null
//             ? SizedBox()
//             : Container(
//                 padding: EdgeInsets.all(constrains.maxWidth * 0.01),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: constrains.maxWidth * .22,
//                       child: ListView.builder(
//                         itemExtent: constrains.maxWidth * 0.19,
//                         itemCount: homeController.getRecentViewed!.length,
//                         itemBuilder: (context, index) => Column(
//                           children: [
//                             Container(
//                               height: constrains.maxWidth * .17,
//                               width: constrains.maxWidth * .17,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   width: 2,
//                                   color: Constants.APP_COLORS[index % 5],
//                                 ),
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                       homeController.getRecentViewed![index]!
//                                           .categoryImage,
//                                     ),
//                                     fit: BoxFit.fill),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 homeController
//                                     .getRecentViewed![index]!.categoryName,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Constants.APP_COLORS[index % 5],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         scrollDirection: Axis.horizontal,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ],
//     );
//   }
// }
