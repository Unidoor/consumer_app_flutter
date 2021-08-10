import 'package:flutter/material.dart';
import 'package:unidoor_ecommerce/constants.dart';

import '../OnBoardingScreen/Views/into_data.dart';

class IntroPageViewWidget extends StatelessWidget {
  const IntroPageViewWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: PageView.builder(
          itemCount: introData.length,
          itemBuilder: (context, index) => IntroData(
            intoImage: introData[index]['image'],
            headText: introData[index]['headText'],
            descText: introData[index]['descText'],
          ),
          // using for bottom linear indicator functioning for when slide to each page
          onPageChanged: (page) {
            // _currentPage = introController.pageNavigation(page);
            // print("onPagechanged = $_currentPage");
          },
        ),
      ),
    );
  }
}
