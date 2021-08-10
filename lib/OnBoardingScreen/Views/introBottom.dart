// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:unidoor_ecommerce/constants.dart';
// import 'package:unidoor_ecommerce/OnBoardingScreen/Controllers/intro_controller.dart';
// import 'package:unidoor_ecommerce/HomeScreen/Views/home_screen.dart';
// // import 'package:unidoor_ecommerce/widgets/dot_indicator.dart';
//
// import '../../widgets/clearDefaultButton.dart';
//
// class IntroBottom extends StatelessWidget {
//   IntroBottom({Key key, this.currentPage, this.controller}) : super(key: key);
//   final int currentPage;
//   final PageController controller;
//   static const _kDuration = const Duration(milliseconds: 300);
//   final IntroController introController = Get.put(IntroController());
//   static const _kCurve = Curves.ease;
//   @override
//   Widget build(BuildContext context) {
//     print("intro page: $controller and $currentPage");
//
//     int _currentPage = currentPage;
//     return (_currentPage == 0 || _currentPage == 5)
//         ? Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width / 2,
//                 padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
//                 // child: LinearProgressIndicator(
//                 //   backgroundColor: kWhiteColor,
//                 //   value: (_currentPage + 1) / (introData.length + 0),
//                 //   valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
//                 // ),
//                 child: Obx(
//                   () => Container(
//                     padding: EdgeInsets.only(right: 40.0),
//                     alignment: Alignment.topRight,
//                     child: DotsIndicator(
//                       dotsCount: introData.length,
//                       position: _currentPage.toDouble(),
//                       // axis: Axis.vertical,
//                       reversed: true,
//                       onTap: (page) {
//                         _currentPage = introController.pageNavigation(page);
//                         print("_current Page: ${_currentPage}");
//                       },
//                       decorator: DotsDecorator(
//                         color: kButtonLight, // Inactive color
//                         activeColor: kPrimaryColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 20),
//                 child: ClearDefaultButton(
//                   name: 'NEXT',
//                   press: (page) {
//                     _currentPage = introController.pageNavigation(page);
//                     controller.nextPage(duration: _kDuration, curve: _kCurve);
//                     print("inside Next Page: $_currentPage");
//                   },
//                 ),
//               ),
//             ],
//           )
//         : ClearDefaultButton(
//             name: 'Lets get started',
//             press: () {
//               Get.to(HomeScreen());
//             },
//           );
//     // });
//   }
// }
