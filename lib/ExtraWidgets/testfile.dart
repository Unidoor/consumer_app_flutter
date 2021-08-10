import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/LoginScreen/Controllers/country-code-controller.dart';
import 'package:unidoor_ecommerce/LoginScreen/Models/contry-code-model.dart';
import 'package:unidoor_ecommerce/AppBar/empty_appbar.dart';
import 'package:unidoor_ecommerce/widgets/bottom_button.dart';
import 'package:unidoor_ecommerce/widgets/login_phone_number.dart';
import 'package:unidoor_ecommerce/widgets/header_static_content.dart';
import 'package:unidoor_ecommerce/constants.dart';

class TestFile extends StatelessWidget {
  final CountryCodeController countryCodeController =
      Get.put(CountryCodeController());

  String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Item'),
      ),
      body: Column(children: [
        GetX<CountryCodeController>(
          // init: Get.put<CountryCodeController>(CountryCodeController()),
          builder: (countryCodeController) {
            print("Controller = ${countryCodeController.countryCode}");
            return Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 12, top: 40, left: 10.0, right: 15.0),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 10,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        isDense:
                            true, // Reduces the dropdowns height by +/- 50%
                        icon: Icon(Icons.keyboard_arrow_down),
                        hint: Text(
                            '${countryCodeController.countryCode.value[0].name}'),
                        value: countryCodeController.countryCode.value[0]
                            .name, //TODO: value should be change
                        items:
                            countryCodeController.countryCode.value.map((item) {
                          print(category);
                          print("item name = ${item.name}");
                          return DropdownMenuItem(
                            value: item.name,
                            child: Text(item.name),
                          );
                        }).toList(),
                        // onChanged: (selectedItem) {
                        //   countryCodeController.setSelected(selectedItem);
                        //TODO : For selecting other countries
                        //   catagory = countryCodeController.selectedItem.value;
                        // }),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
