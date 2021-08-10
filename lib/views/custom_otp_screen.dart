import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/RegisterScreen/Views/address_registration_screen.dart';
import 'package:unidoor_ecommerce/widgets/header_static_content.dart';

class Otp extends StatefulWidget {
  final int phoneNumber;

  const Otp({
    Key key,
    @required this.phoneNumber,
  }) : super(key: key);

  @override
  _OtpState createState() => new _OtpState();
}

class _OtpState extends State<Otp> with SingleTickerProviderStateMixin {
  // Constants
  final int time = 5;
  AnimationController _controller;

  // Variables
  Size _screenSize;
  //int _currentDigit;
  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;
  int _fifthDigit;
  int _sixthDigit;

  Timer timer;
  int totalTimeInSeconds;
  bool _hideResendButton;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  // Returns "Appbar"
  get _getAppbar {
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: new InkWell(
        borderRadius: BorderRadius.circular(30.0),
        child: new Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
    );
  }

  // Return "Verification Code" label
  get _getVerificationCodeLabel {
    return HeaderStaticContent(
      headerText: "Verify +91 85555 55525",
    );
  }

  // Return "Email" label
  get _getEmailLabel {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: verificationContent,
        style: kSubTitleText,
        children: <TextSpan>[
          TextSpan(
            text: wrongNumber,
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // Return "OTP" input field
  get _getInputField {
    return Container(
      padding: EdgeInsets.only(left: 50.0, right: 50.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _otpTextField(_firstDigit),
          _otpTextField(_secondDigit),
          _otpTextField(_thirdDigit),
          SizedBox(
            width: 20.0,
          ),
          _otpTextField(_fourthDigit),
          _otpTextField(_fifthDigit),
          _otpTextField(_sixthDigit),
        ],
      ),
    );
  }

  get _getDigitsLabel {
    return new Text(
      "Enter 6-digit code",
      textAlign: TextAlign.center,
      style: new TextStyle(
          fontSize: 18.0,
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.w600),
    );
  }

  get _getBottomLine {
    return Container(
      padding: EdgeInsets.only(
        left: 55.0,
        right: 55.0,
      ),
      child: Divider(
        color: kPrimaryColor,
        thickness: 2.0,
      ),
    );
  }

  // Returns "OTP" input part
  get _getInputPart {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // _getVerificationCodeLabel,
        // SizedBox(
        //   height: 30.0,
        // ),
        // _getEmailLabel,
        // SizedBox(
        //   height: 30.0,
        // ),
        Column(
          children: [
            _getInputField,
            SizedBox(
              height: 20.0,
            ),
            _getBottomLine,
            SizedBox(
              height: 10.0,
            ),
            _getDigitsLabel,
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: _getResendButton,
                ),
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    child: _getTimerText,
                  ),
                ),
              ],
            )
          ],
        ),
        // _getOtpKeyboard
      ],
    );
  }

  // Returns "Timer" label
  get _getTimerText {
    return Container(
      height: 32,
      child: new Offstage(
        offstage: !_hideResendButton,
        child: OtpTimer(_controller, 15.0, Colors.black),
      ),
    );
  }

  // Returns "Resend" button
  get _getResendButton {
    return MaterialButton(
      child: Container(
        height: 32,
        width: 150,
        // decoration: BoxDecoration(
        //     color: Colors.black,
        //     shape: BoxShape.rectangle,
        //     borderRadius: BorderRadius.circular(32)),
        alignment: Alignment.center,
        child: !_hideResendButton
            ? Row(
                children: [
                  Icon(
                    Icons.message,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    child: Text(
                      "Resend SMS",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                  ),
                ],
              )
            : Opacity(
                opacity: 0.5,
                child: Row(
                  children: [
                    Icon(Icons.message),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: Text(
                        "Resend SMS",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: kBlack),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      onPressed: () {
        Get.to(
          AddressRegistrationScreen(),
          arguments: [],
        );
      },
    );
  }

  // Returns "Otp" keyboard
  // get _getOtpKeyboard {
  //   return new Container(
  //       height: _screenSize.width - 80,
  //       child: new Column(
  //         children: <Widget>[
  //           new Expanded(
  //             child: new Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 _otpKeyboardInputButton(
  //                     label: "1",
  //                     onPressed: () {
  //                       _setCurrentDigit(1);
  //                     }),
  //                 _otpKeyboardInputButton(
  //                     label: "2",
  //                     onPressed: () {
  //                       _setCurrentDigit(2);
  //                     }),
  //                 _otpKeyboardInputButton(
  //                     label: "3",
  //                     onPressed: () {
  //                       _setCurrentDigit(3);
  //                     }),
  //               ],
  //             ),
  //           ),
  //           new Expanded(
  //             child: new Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 _otpKeyboardInputButton(
  //                     label: "4",
  //                     onPressed: () {
  //                       _setCurrentDigit(4);
  //                     }),
  //                 _otpKeyboardInputButton(
  //                     label: "5",
  //                     onPressed: () {
  //                       _setCurrentDigit(5);
  //                     }),
  //                 _otpKeyboardInputButton(
  //                     label: "6",
  //                     onPressed: () {
  //                       _setCurrentDigit(6);
  //                     }),
  //               ],
  //             ),
  //           ),
  //           new Expanded(
  //             child: new Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 _otpKeyboardInputButton(
  //                     label: "7",
  //                     onPressed: () {
  //                       _setCurrentDigit(7);
  //                     }),
  //                 _otpKeyboardInputButton(
  //                     label: "8",
  //                     onPressed: () {
  //                       _setCurrentDigit(8);
  //                     }),
  //                 _otpKeyboardInputButton(
  //                     label: "9",
  //                     onPressed: () {
  //                       _setCurrentDigit(9);
  //                     }),
  //               ],
  //             ),
  //           ),
  //           new Expanded(
  //             child: new Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 new SizedBox(
  //                   width: 80.0,
  //                 ),
  //                 _otpKeyboardInputButton(
  //                     label: "0",
  //                     onPressed: () {
  //                       _setCurrentDigit(0);
  //                     }),
  //                 _otpKeyboardActionButton(
  //                     label: new Icon(
  //                       Icons.backspace,
  //                       color: Colors.black,
  //                     ),
  //                     onPressed: () {
  //                       setState(() {
  //                         if (_sixthDigit != null) {
  //                           _sixthDigit = null;
  //                         } else if (_fifthDigit != null) {
  //                           _fifthDigit = null;
  //                         } else if (_fourthDigit != null) {
  //                           _fourthDigit = null;
  //                         } else if (_thirdDigit != null) {
  //                           _thirdDigit = null;
  //                         } else if (_secondDigit != null) {
  //                           _secondDigit = null;
  //                         } else if (_firstDigit != null) {
  //                           _firstDigit = null;
  //                         }
  //                       });
  //                     }),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ));
  // }

  // Overridden methods
  @override
  void initState() {
    totalTimeInSeconds = time;
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton;
              });
            }
          });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: new Container(
        width: _screenSize.width,
//        padding: new EdgeInsets.only(bottom: 16.0),
        child: _getInputPart,
      ),
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return new Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: new Text(
        digit != null ? digit.toString() : "",
        style: new TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
      decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
          border: Border(
              bottom: BorderSide(
        width: 2.0,
        color: Colors.black,
      ))),
    );
  }

  // Returns "Otp keyboard input Button"
  // Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
  //   return new Material(
  //     color: Colors.transparent,
  //     child: new InkWell(
  //       onTap: onPressed,
  //       borderRadius: new BorderRadius.circular(40.0),
  //       child: new Container(
  //         height: 80.0,
  //         width: 80.0,
  //         decoration: new BoxDecoration(
  //           shape: BoxShape.circle,
  //         ),
  //         child: new Center(
  //           child: new Text(
  //             label,
  //             style: new TextStyle(
  //               fontSize: 30.0,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Returns "Otp keyboard action Button"
  // _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
  //   return new InkWell(
  //     onTap: onPressed,
  //     borderRadius: new BorderRadius.circular(40.0),
  //     child: new Container(
  //       height: 80.0,
  //       width: 80.0,
  //       decoration: new BoxDecoration(
  //         shape: BoxShape.circle,
  //       ),
  //       child: new Center(
  //         child: label,
  //       ),
  //     ),
  //   );
  // }

  // Current digit
  // void _setCurrentDigit(int i) {
  //   setState(() {
  //     _currentDigit = i;
  //     if (_firstDigit == null) {
  //       _firstDigit = _currentDigit;
  //     } else if (_secondDigit == null) {
  //       _secondDigit = _currentDigit;
  //     } else if (_thirdDigit == null) {
  //       _thirdDigit = _currentDigit;
  //     } else if (_fourthDigit == null) {
  //       _fourthDigit = _currentDigit;
  //     } else if (_fifthDigit == null) {
  //       _fifthDigit = _currentDigit;
  //     } else if (_sixthDigit == null) {
  //       _sixthDigit = _currentDigit;
  //       // var otp = _firstDigit.toString() +
  //       //     _secondDigit.toString() +
  //       //     _thirdDigit.toString() +
  //       //     _fourthDigit.toString() +
  //       //     _fifthDigit.toString() +
  //       //     _sixthDigit.toString();
  //
  //       // Verify your otp by here. API call
  //     }
  //   });
  // }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  void clearOtp() {
    _sixthDigit = null;
    _fifthDigit = null;
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
  }
}

class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  double fontSize;
  Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if (duration.inHours > 0) {
      return '${(duration.inHours).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return new Text(
            timerString,
            style: new TextStyle(
                fontSize: fontSize,
                color: timeColor,
                fontWeight: FontWeight.w600),
          );
        });
  }
}
