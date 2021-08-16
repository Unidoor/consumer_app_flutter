import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// const kPrimaryColor = Color(0xff25D366);
const kPrimaryColor = Color(0xff017E01);

const kTransparent = Colors.transparent;
const kAccentColor = Color(0xFFF1F1F1);
const kWhiteColor = Color(0xffffffff);
const kLightColor = Color(0xFF707070);
const kButtonLight = Color(0xFFC7C7C7);
const kBlack = Color(0xFF000000);
const kRatingStart = Color(0xFFFFC107);
const kPriceColor = Color(0xFFFF7D7D);
const kQuantityButton = Color(0xFFFA5555);
const kOfferText = Color(0xFF02CB02);
const kMoreOrLess = Color(0xFF00C4EC);
const kOutOfStock = Color(0xFFFF0000);

const kDefaultPadding = 24.0;
const kLessPadding = 10.0;
const kFixedPadding = 16.0;
const kShape = 30.0;

const kAppBarHeight = 56.0;
const kRadius = 0.0;

const kDefaultSize = 30.0;

const kTitleTextStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: 23.0,
);

const kSubTitleText = TextStyle(
  fontSize: 20.0,
  color: kBlack,
);

const kSubTextStyle = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor,
);

const kHeadTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
);
const kSplashScreenLabel = TextStyle(fontSize: 30.0, color: kPrimaryColor);

const String loginSuggesions =
    "App name will send an SMS message to verify your phone number. Enter your phone number";
const String verificationContent =
    "Waiting to automatically detect an SMS send to ";
const String wrongNumber = " wrong number?";
const String otpcode = "Enter 6-digit code";

//images
const kLogoImage = Image(
  height: 124.0,
  width: 123.0,
  image: AssetImage('assets/images/logo_unidoor.png'),
);

const String intro1 = "assets/images/intro1.svg";
const String intro2 = "assets/images/intro2.svg";
const String intro3 = "assets/images/intro3.svg";

var introData = [
  {
    'image': intro1,
    'headText': 'Fast delivery',
    'descText': 'Here you can get your orders quickly',
  },
  {
    'image': intro2,
    'headText': 'Easy sale & purchase',
    'descText':
        'you can sale your own products and purchase from nearby stores',
  },
  {
    'image': intro3,
    'headText': 'Pick up your orders',
    'descText': 'We have an option to pick up your products',
  }
];

// const kAddressImage = SvgPicture.asset();
