import 'package:get/get.dart';
import 'package:unidoor_ecommerce/seller_account_registration/Models/seller_business_type_model.dart';
import 'package:unidoor_ecommerce/seller_account_registration/Services/seller_business_type_Api.dart';

class SellerBusinessTypeController extends GetxController {
  var sellerBusinessType = RxList<Datum>().obs;
  var selectedBusinessType = "".obs;
  var selectedBusinessTypeID = "".obs;

  @override
  void onInit() {
    print("init called");
    super.onInit();
    fetchSellerBusinessType();
  }

  Future<void> fetchSellerBusinessType() async {
    print("fetch method called");
    var sellerBusinessTypeList =
        await SellerBusinessType.getSellerBusinessType();
    selectedBusinessType.value = sellerBusinessTypeList.first.name;
    selectedBusinessTypeID.value = sellerBusinessTypeList.first.id;
    // print("country code List :$countryCodeList");
    for (Datum datum in sellerBusinessTypeList) {
      sellerBusinessType.value.add(datum);
    }
    // if (countryCodeList != null) {
    //   countryCode.value = countryCodeList;
    //   print("countryCode = ${countryCode}");
    // }
  }

  void setSelectedBusinessType(String value) {
    selectedBusinessType.value = value;
    int index =
        sellerBusinessType.value.indexWhere((element) => element.name == value);
    selectedBusinessTypeID.value = sellerBusinessType.value[index].id;
  }
}
