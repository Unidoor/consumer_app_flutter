import 'package:flutter/material.dart';
import 'package:unidoor_ecommerce/constants.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kTransparent,
      elevation: kRadius,
      automaticallyImplyLeading: false,
    );
  }
}
