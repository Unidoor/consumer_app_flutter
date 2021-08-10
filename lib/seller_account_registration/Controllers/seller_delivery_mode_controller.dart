import 'package:get/get.dart';
import 'package:unidoor_ecommerce/seller_account_registration/Models/seller_delivery_mode_model.dart';
import 'package:unidoor_ecommerce/seller_account_registration/Services/seller_delivery_mode_Api.dart';

class SellerDeliveryModeController extends GetxController {
  var sellerDeliveryMode = RxList<Datum>().obs;
  var selectedDeliveryMode = "".obs;
  var selectedDeliveryID = "".obs;

  @override
  void onInit() {
    print("init called");
    super.onInit();
    fetchSellerDeliveryMode();
  }

  Future<void> fetchSellerDeliveryMode() async {
    print("fetch method called");
    var sellerDeliveryModeList =
        await SellerDeliveryMode.getSellerDeliveryMode();
    selectedDeliveryMode.value = sellerDeliveryModeList.first.name;
    selectedDeliveryID.value = sellerDeliveryModeList.first.id;
    // print("country code List :$countryCodeList");
    for (Datum datum in sellerDeliveryModeList) {
      sellerDeliveryMode.value.add(datum);
    }
    // if (countryCodeList != null) {
    //   countryCode.value = countryCodeList;
    //   print("countryCode = ${countryCode}");
    // }
  }

  void setSelectedDeliveryMode(String value) {
    selectedDeliveryMode.value = value;
    int index =
        sellerDeliveryMode.value.indexWhere((element) => element.name == value);
    selectedDeliveryID.value = sellerDeliveryMode.value[index].id;
  }
}
