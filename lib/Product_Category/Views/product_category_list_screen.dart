import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/constants.dart';

class ProductCategoryListScreen extends StatelessWidget {
  const ProductCategoryListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kWhiteColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select products",
              textAlign: TextAlign.left,
            ),
            Text(
              "123 products",
              style: TextStyle(fontSize: 14.0),
            )
          ],
        ),
        actions: [
          Image(
            image: AssetImage("assets/images/discount_icon.png"),
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Badge(
              badgeColor: kWhiteColor,
              badgeContent: Text(
                '3',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Container(),
            Container(
              margin: EdgeInsets.all(30),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  color: kPrimaryColor,
                  onPressed: () {},
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(color: kWhiteColor),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: kWhiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
