import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/HomeScreen/Views/home_screen.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/OnBoardingScreen/Controllers/intro_controller.dart';
import 'package:unidoor_ecommerce/OnBoardingScreen/Views/into_data.dart';
import 'package:unidoor_ecommerce/OnBoardingScreen/Views/introBottom.dart';
import 'package:unidoor_ecommerce/widgets/clearDefaultButton.dart';

import '../../AppBar/empty_appbar.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  var _currentPage = 0;

  final _controller = new PageController(
    initialPage: 0,
  );
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  // final IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    // _controller.addListener(() {
    //   _currentPage = _controller.page.round();
    // });
    return Scaffold(
        appBar: EmptyAppBar(),
        body: Column(children: [
          (_currentPage == 0 || _currentPage == 1)
              ? Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(right: 30.0),
                  child: TextButton(
                    child: Text(
                      "SKIP",
                      style: kTitleTextStyle,
                      textAlign: TextAlign.right,
                    ),
                    onPressed: () {
                      Get.to(HomeScreen());
                    },
                  ),
                )
              : Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(right: 30.0),
                  child: TextButton(
                    child: Text(
                      "",
                      style: kTitleTextStyle,
                      textAlign: TextAlign.right,
                    ),
                    onPressed: () {
                      //Get.to(HomeScreen());
                    },
                  ),
                ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            flex: 1,
            child: PageView.builder(
              controller: _controller,
              itemCount: introData.length,
              itemBuilder: (context, index) => IntroData(
                intoImage: introData[index]['image'],
                headText: introData[index]['headText'],
                descText: introData[index]['descText'],
              ),
              // using for bottom linear indicator functioning for when slide to each page
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
                print("onPagechanged = $_currentPage");
              },
            ),
          ),

          (_currentPage == 0 || _currentPage == 1)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                      margin: EdgeInsets.only(bottom: 40, right: 40.0),
                      // padding: EdgeInsets.only(right: 40.0),
                      alignment: Alignment.topRight,
                      child: DotsIndicator(
                        dotsCount: introData.length,
                        position: _currentPage.toDouble(),
                        // axis: Axis.vertical,
                        reversed: false,
                        onTap: (page) {},
                        decorator: DotsDecorator(
                          color: kButtonLight, // Inactive color
                          activeColor: kPrimaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      margin: EdgeInsets.only(bottom: 40),
                      // alignment: Alignment.topRight,
                      // padding: EdgeInsets.only(right: 30.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            primary: kPrimaryColor,
                            backgroundColor: kTransparent,
                            padding: EdgeInsets.symmetric(
                                vertical: kDefaultPadding)),
                        onPressed: () {
                          setState(() {
                            _controller.nextPage(
                                duration: _kDuration, curve: _kCurve);
                          });
                        },
                        child: Text(
                          "Next".toUpperCase(),
                          style: kSubTextStyle,
                        ),
                      ),
                    )
                  ],
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 40),
                  // padding: EdgeInsets.only(right: 40.0),
                  // alignment: Alignment.topRight,
                  child: MaterialButton(
                    // onPressed: () async {
                    //   await uploadImageController.submitAddress();
                    // Get.to(
                    //   HomeScreen(),
                    // );
                    // },
                    onPressed: () {
                      Get.to(
                        HomeScreen(),
                      );
                    },
                    child: Text("Lets get started"),
                    height: 40.0,
                    minWidth: MediaQuery.of(context).size.width - 50,
                    color: Theme.of(context).primaryColor,
                    textColor: kWhiteColor,
                    elevation: 1.0,
                    splashColor: kTransparent,
                  ),
                  // child: ClearDefaultButton(
                  //   name: 'Lets get started',
                  //   press: () {
                  //     Get.to(HomeScreen());
                  //   },
                  // ),
                )
          // IntroBottom(currentPage: _currentPage, controller: _controller),
        ]));
  }
}
