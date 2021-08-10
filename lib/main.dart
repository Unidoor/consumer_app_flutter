import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:unidoor_ecommerce/ExtraWidgets/testfile.dart';
import 'package:unidoor_ecommerce/LocationScreen/Views/loction_screen.dart';
import 'package:unidoor_ecommerce/RegisterScreen/Views/address_registration_screen.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/HomeScreen/Views/home_screen.dart';
import 'package:unidoor_ecommerce/LoginScreen/Views/login_screen.dart';
import 'package:unidoor_ecommerce/SplashScreen/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'OnBoardingScreen/Views/intro_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: kTransparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Replace the 3 second delay with your initialization code:
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GetMaterialApp(home: SplashScreen());
          } else {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: kPrimaryColor,
                accentColor: kAccentColor,
              ),
              // home: LoginScreen(),
              // home: LocationScreen(),
              home: HomeScreen(),
            );
          }
        });
  }
}
