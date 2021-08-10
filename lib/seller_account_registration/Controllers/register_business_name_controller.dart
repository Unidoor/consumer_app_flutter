import 'package:get/get.dart';

class RegisterBusinessNameController extends GetxController {
  RxString sellerName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    //debounce(username, validations, time: Duration(milliseconds: 500));
  }

  void getBusinessName(String val) {
    sellerName.value = val;
    print(sellerName.value);
  }
}
