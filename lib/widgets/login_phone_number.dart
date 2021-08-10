import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/LoginScreen/Controllers/phoneNumber_controller.dart';

class LoginPhoneNumber extends StatelessWidget {
  final String phoneNumber;
  final String intCode;

  LoginPhoneNumber({
    Key key,
    this.phoneNumber,
    this.intCode,
  }) : super(key: key);

  final PhoneNumberController phoneNumberController =
      Get.put(PhoneNumberController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          Container(
            width: 50.0,
            height: 30.0,
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    intCode,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Container(
            child: Expanded(
              child: Obx(
                () {
                  print(
                      'rebuild TextFormField: ${phoneNumberController.errorText.value}');
                  return Container(
                    height: 70.0,
                    padding: EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                      decoration: InputDecoration(
                        errorText: phoneNumberController.errorText.value,
                      ),
                      onChanged: (newValue) {
                        phoneNumberController.phoneNumberChanged(newValue);
                      },
                      style: TextStyle(fontSize: 18.0, letterSpacing: 1.0),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
