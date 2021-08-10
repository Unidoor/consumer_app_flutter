import 'package:flutter/material.dart';
import 'package:unidoor_ecommerce/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kLogoImage,
              // Icon(
              //   Icons.apartment_outlined,
              //   size: MediaQuery.of(context).size.width * 0.785,
              // ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Unidoor",
                style: kSplashScreenLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
