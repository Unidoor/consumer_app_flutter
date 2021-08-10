import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/HomeScreen/Views/home_screen.dart';

class IntroData extends StatelessWidget {
  final String intoImage, headText, descText;
  const IntroData({Key key, this.intoImage, this.headText, this.descText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height - 500,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: SvgPicture.asset(
              intoImage,
              width: MediaQuery.of(context).size.width - 50,
              //color: kWhiteColor,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 50.0,
        ),
        Text(
          headText,
          textAlign: TextAlign.center,
          style: kHeadTextStyle,
        ),
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Text(
            descText,
            textAlign: TextAlign.center,
            style: kSubTitleText,
          ),
        ),
        // PageView.builder(
        //   itemCount: introData.length,
        //   itemBuilder: (context, index) => IntroData(),
        // ),
      ],
    );
  }
}
