import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:unidoor_ecommerce/LoginScreen/Controllers/otp_conroller.dart';
import 'package:unidoor_ecommerce/AppBar/empty_appbar.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/LoginScreen/Views/login_screen.dart';
import 'package:unidoor_ecommerce/widgets/header_static_content.dart';
import 'package:unidoor_ecommerce/widgets/timer_widget.dart';

import '../../RegisterScreen/Views/address_registration_screen.dart';
import '../../OnBoardingScreen/Views/intro_screen.dart';

class VerificationScreen extends StatelessWidget {
  // var phoneNumber;
  // var intrCode;
  String verificationNumber;

  String enteredOtp;
  String otpCodeValue;
  var identifier;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  // var userPhoneNumber;
  //
  // VerificationScreen(this.userPhoneNumber);

  // int phoneNumber;

  // VerificationScreen({this.phoneNumber, this.intrCode, IntrCode});
  final OtpController getOtpController = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    print("Verification number is : ${Get.arguments[0].toString()}");
    print("Verification number is : ${getOtpController.otpValue.value}");
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        child: SafeArea(
          child: Container(
            child: GetX<OtpController>(
              // init: Get.put(CountryCodeController()),
              builder: (controller) {
                verificationNumber = Get.arguments[0].toString();
                // controller.otpValue.value.map((item) {
                //   otpCodeValue = item.otpCode;
                //   identifier = item.identifier;
                //   print("Otp first = $otpCodeValue");
                // });
                // if (getOtpController.otpValue.value != null) {
                //   Get.snackbar(
                //     "OTP",
                //     "Enter this OTP ${controller.otpValue.value[0].otpCode}",
                //     //icon: Icon(Icons.person, color: Colors.white),
                //     snackPosition: SnackPosition.BOTTOM,
                //   );
                // }
                print("Otp verification screen :$verificationNumber");
                return getOtpController.otpValue.value.isNotEmpty
                    ? Column(
                        children: [
                          HeaderStaticContent(
                            headerText: "Verify ${Get.arguments[0]}",
                          ),
                          SizedBox(
                            height: kDefaultSize,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  verificationContent + "${Get.arguments[0]}.",
                              style: kSubTitleText,
                              children: <TextSpan>[
                                TextSpan(
                                  text: wrongNumber,
                                  recognizer: LongPressGestureRecognizer()
                                    ..onLongPress = () {
                                      Get.to(LoginScreen());
                                    },
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: kDefaultSize,
                          ),
                          // Container(
                          //   child: PinCodeTextField(
                          //     length: 6,
                          //     obscureText: false,
                          //     animationType: AnimationType.fade,
                          //     pinTheme: PinTheme(
                          //       shape: PinCodeFieldShape.underline,
                          //       borderRadius: BorderRadius.circular(5),
                          //       activeFillColor: Colors.white,
                          //     ),
                          //     animationDuration: Duration(milliseconds: 300),
                          //     enableActiveFill: false,
                          //     // errorAnimationController: errorController,
                          //     // controller: textEditingController,
                          //     onCompleted: (v) {
                          //       print("Completed");
                          //     },
                          //     onChanged: (value) {
                          //       print(value);
                          //       // setState(() {
                          //       //   currentText = value;
                          //       // });
                          //     },
                          //     beforeTextPaste: (text) {
                          //       print("Allowing to paste $text");
                          //       //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //       //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          //       return true;
                          //     },
                          //   ),
                          // ),
                          // Container(
                          //   padding: EdgeInsets.only(left: 40.0, right: 40.0),
                          //   child: Center(
                          //     child: OTPTextField(
                          //       length: 6,
                          //       width: MediaQuery.of(context).size.width - 100,
                          //       textFieldAlignment: MainAxisAlignment.spaceAround,
                          //       fieldWidth: 10,
                          //       fieldStyle: FieldStyle.underline,
                          //       outlineBorderRadius: 15,
                          //       style: TextStyle(fontSize: 17),
                          //       onChanged: (pin) {
                          //         print("Changed: " + pin);
                          //         enteredOtp = pin;
                          //         print("Changed: " + enteredOtp);
                          //       },
                          //       onCompleted: (pin) {
                          //         if (pin != controller.otpValue.value[0].otpCode) {
                          //           print("Otp =$controller");
                          //           showDialog(
                          //               context: context,
                          //               builder: (context) {
                          //                 return AlertDialog(
                          //                   title: Text("Alert"),
                          //                   content:
                          //                       Text("Please enter the correct OTP"),
                          //                 );
                          //               });
                          //         } else {
                          //           Get.off(AddressRegistrationScreen());
                          //         }
                          //       },
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    // height: 40,
                                    child: PinPut(
                                      withCursor: true,
                                      cursor: Container(
                                        width: 1,
                                        height: 25,
                                        color: const Color.fromRGBO(
                                            27, 117, 12, 1),
                                      ),
                                      separatorPositions: [3],
                                      fieldsCount: 6,
                                      keyboardType: TextInputType.number,
                                      preFilledWidget: Center(
                                        child: Container(
                                          height: 1.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          color: kPrimaryColor,
                                          // const Color.fromRGBO(112, 112, 112, 1),
                                        ),
                                      ),
                                      eachFieldMargin: EdgeInsets.zero,
                                      onSubmit: (String pin) {},
                                      focusNode: _pinPutFocusNode,
                                      controller: _pinPutController,
                                      onChanged: (String pin) {
                                        if (pin.length == 6) {
                                          if (pin !=
                                              controller
                                                  .otpValue.value[0].otpCode) {
                                            print("Otp =$controller");
                                            // Get.defaultDialog(
                                            //   title: "Unidoor Alert",
                                            //   middleText:
                                            //       "Please enter the correct OTP!",
                                            //   backgroundColor: Colors.green,
                                            //   titleStyle: TextStyle(
                                            //       color: Colors.white),
                                            //   middleTextStyle: TextStyle(
                                            //       color: Colors.white),
                                            // );
                                            // Get.dialog(
                                            //   AlertDialog(
                                            //     title: Text(
                                            //         "This should not be closed automatically"),
                                            //     content: Text(
                                            //         "This should not be closed automatically"),
                                            //     actions: <Widget>[
                                            //       TextButton(
                                            //         child: Text("CLOSE"),
                                            //         onPressed: () {
                                            //           Navigator.of(context,
                                            //                   rootNavigator:
                                            //                       true)
                                            //               .pop(pin);
                                            //         },
                                            //       ),
                                            //     ],
                                            //   ),
                                            //   barrierDismissible: false,
                                            // );
                                            Get.snackbar(
                                              "Your OTP",
                                              "Please enter your correct OTP ${controller.otpValue.value[0].otpCode}",
                                              icon: Icon(Icons.person,
                                                  color: Colors.white),
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                            );
                                          } else {
                                            Get.off(
                                                AddressRegistrationScreen());
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  color: const Color.fromRGBO(27, 117, 12, 1),
                                  height: 3,
                                  width: double.infinity,
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  'Enter 6-digit code',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: OtpTimer(Get.arguments),
                          ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 10,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
