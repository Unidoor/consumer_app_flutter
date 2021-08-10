import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/LoginScreen/Controllers/phoneNumber_controller.dart';
import 'package:unidoor_ecommerce/LoginScreen/Controllers/country-code-controller.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/LoginScreen/Views/verification_screen.dart';

class BottomButton extends StatelessWidget {
  final String phoneNumber, IntrCode;
  const BottomButton({Key key, this.phoneNumber, this.IntrCode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CountryCodeController countryCodeController =
        Get.put(CountryCodeController());
    final PhoneNumberController phoneNumberController =
        Get.put(PhoneNumberController());
    final userPhoneNumber =
        "${countryCodeController.countryCode.value}+${phoneNumberController.phoneNumber.value}";
    return MaterialButton(
      onPressed: () {
        print(
            " the intr code and phone numbers are : ${countryCodeController.phoneNumber.value} and ${phoneNumberController.phoneNumber.value}");
        Get.to(
          VerificationScreen(),
          arguments: [
            countryCodeController.phoneNumber.value +
                phoneNumberController.phoneNumber.value
          ],
        );
      },
      child: Text("Next".toUpperCase()),
      height: 40.0,
      minWidth: 100.0,
      color: Theme.of(context).primaryColor,
      textColor: kWhiteColor,
      elevation: 1.0,
      splashColor: kTransparent,
    );
  }
}
