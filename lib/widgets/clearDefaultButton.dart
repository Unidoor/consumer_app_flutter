import 'package:flutter/material.dart';
import 'package:unidoor_ecommerce/constants.dart';

class ClearDefaultButton extends StatelessWidget {
  final Function press;
  final String name;
  const ClearDefaultButton({
    Key key,
    this.press,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            primary: kPrimaryColor,
            backgroundColor: kTransparent,
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding)),
        onPressed: press,
        child: Text(
          name.toUpperCase(),
          style: kSubTextStyle,
        ));
  }
}
