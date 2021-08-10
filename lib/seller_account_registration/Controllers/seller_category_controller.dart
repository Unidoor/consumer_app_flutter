import 'package:get/get.dart';
import 'package:unidoor_ecommerce/seller_account_registration/Models/seller_category_model.dart';
import 'package:unidoor_ecommerce/seller_account_registration/Services/seller_category_Api.dart';

class SellerCategoryController extends GetxController {
  var sellerCategory = RxList<Datum>().obs;
  var selectedCategory = "".obs;
  var selectedCategoryID = "".obs;

  @override
  void onInit() {
    print("init called");
    super.onInit();
    fetchSellerDeliveryMode();
  }

  Future<void> fetchSellerDeliveryMode() async {
    print("fetch method called");
    var sellerDeliveryModeList = await SellerCategory.getSellerCategory();
    selectedCategory.value = sellerDeliveryModeList.first.name;
    selectedCategoryID.value = sellerDeliveryModeList.first.id;
    // print("country code List :$countryCodeList");
    for (Datum datum in sellerDeliveryModeList) {
      sellerCategory.value.add(datum);
    }
    // if (countryCodeList != null) {
    //   countryCode.value = countryCodeList;
    //   print("countryCode = ${countryCode}");
    // }
  }

  void setSelectedCategory(String value) {
    selectedCategory.value = value;
    int index =
        sellerCategory.value.indexWhere((element) => element.name == value);
    selectedCategoryID.value = sellerCategory.value[index].id;
  }
}
