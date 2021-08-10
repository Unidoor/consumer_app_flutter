import 'package:flutter/material.dart';
import 'package:unidoor_ecommerce/constants.dart';

class HeaderStaticContent extends StatelessWidget {
  final String headerText;

  const HeaderStaticContent({
    Key key,
    this.headerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      textAlign: TextAlign.center,
      style: kTitleTextStyle,
    );
  }
}
