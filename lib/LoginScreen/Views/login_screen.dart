import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/LoginScreen/Controllers/country-code-controller.dart';
import 'package:unidoor_ecommerce/AppBar/empty_appbar.dart';
import 'package:unidoor_ecommerce/widgets/bottom_button.dart';
import 'package:unidoor_ecommerce/widgets/login_phone_number.dart';
import 'package:unidoor_ecommerce/widgets/header_static_content.dart';
import 'package:unidoor_ecommerce/constants.dart';

class LoginScreen extends StatelessWidget {
  final CountryCodeController countryCodeController =
      Get.put(CountryCodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: EmptyAppBar(),
      body: Container(
        child: SafeArea(
          child: GetX<CountryCodeController>(
            // init: Get.put(CountryCodeController()),
            builder: (countryCodeController) {
              print("Controller =${countryCodeController.countryCode}");
              return countryCodeController.countryCode.value.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(kDefaultPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                HeaderStaticContent(
                                  headerText: "Verify your phone number",
                                ),
                                SizedBox(
                                  height: kDefaultSize,
                                ),
                                Text(
                                  loginSuggesions,
                                  style: kSubTitleText,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: kDefaultSize,
                                ),
                                Container(
                                  // padding: const EdgeInsets.symmetric(
                                  //     horizontal: 16),
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.green,
                                        ),
                                      ),
                                      prefixIcon: Center(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            iconSize: 0.0,
                                            // iconEnabledColor: kTransparent,
                                            // iconEnabledColor: kTransparent,
                                            // iconDisabledColor: kTransparent,
                                            // hint: Text(
                                            //   '${countryCodeController.countryCode[0].name}',
                                            // ),
                                            onChanged: null,
                                            // onChanged: (newValue) {
                                            //   // TODO : For selecting other countries
                                            //   print(
                                            //       "Value ======$newValue====");
                                            //   countryCodeController
                                            //       .setSelected(newValue);
                                            // },

                                            value: countryCodeController
                                                .selectedValue.value,
                                            items: countryCodeController
                                                .countryCode.value
                                                .map((item) {
                                              // print("Item : $item");
                                              // print(category);
                                              print("item name = ${item.name}");
                                              return DropdownMenuItem<String>(
                                                value: item.name,
                                                child: Container(
                                                  width: 300,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "${item.name}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 24.0,
                                                        color: kBlack),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: kDefaultSize,
                                ),
                                LoginPhoneNumber(
                                  intCode:
                                      countryCodeController.phoneNumber.value,
                                ),
                              ],
                            ),
                          ),
                        ),
                        BottomButton(),
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
    );
  }
}
