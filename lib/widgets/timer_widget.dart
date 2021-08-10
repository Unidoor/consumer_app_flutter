import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/LoginScreen/Controllers/otp_conroller.dart';
import 'package:unidoor_ecommerce/RegisterScreen/Views/address_registration_screen.dart';

class OtpTimer extends StatefulWidget {
  var phoneNumber;
  // double fontSize;
  // Color timeColor = Colors.black;
  //
  OtpTimer(this.phoneNumber);

  @override
  _OtpTimerState createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer>
    with SingleTickerProviderStateMixin {
  final int time = 2;
  AnimationController _controller;

  Timer timer;
  int totalTimeInSeconds;
  bool _hideResendButton;

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

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  String get timerString {
    Duration duration = _controller.duration * _controller.value;
    if (duration.inHours > 0) {
      return '${(duration.inHours).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = _controller.duration;
    return duration;
  }

  get _getResendButton {
    return MaterialButton(
      child: Container(
        height: 50,
        width: 180,
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
                    child: TextButton(
                      style: ButtonStyle(
                        minimumSize: ButtonStyleButton.allOrNull(Size.infinite),
                      ),
                      onPressed: () {
                        OtpController otpController = new OtpController();
                        otpController.fetchOtp(widget.phoneNumber);
                      },
                      child: Text(
                        "Resend SMS",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: _getResendButton,
        ),
        Container(
          padding: EdgeInsets.only(right: 20.0),
          child: Offstage(
            offstage: !_hideResendButton,
            child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return new Text(
                    timerString,
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: kBlack,
                        fontWeight: FontWeight.w600),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
