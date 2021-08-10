import 'package:get/state_manager.dart';
import 'package:unidoor_ecommerce/LoginScreen/Models/contry-code-model.dart';
import 'package:unidoor_ecommerce/services/country_code_api_manager.dart';

class CountryCodeController extends GetxController {
  var countryCode = RxList<Datum>().obs;
  var selectedValue = "".obs;
  var phoneNumber = "".obs;

  @override
  void onInit() {
    print("init called");
    super.onInit();
    fetchCountryCode();
  }

  void fetchCountryCode() async {
    print("fetch method called");
    var countryCodeList = await ApiManager.getCountryCode();
    selectedValue.value = countryCodeList.first.name;
    phoneNumber.value = countryCodeList.first.intlCode;
    // print("country code List :$countryCodeList");
    for (Datum datum in countryCodeList) {
      countryCode.value.add(datum);
    }
    // if (countryCodeList != null) {
    //   countryCode.value = countryCodeList;
    //   print("countryCode = ${countryCode}");
    // }
  }

  void setSelected(String value) {
    selectedValue.value = value;
    int index =
        countryCode.value.indexWhere((element) => element.name == value);
    phoneNumber.value = countryCode.value[index].intlCode;
  }
}
