import 'package:get/get.dart';

class RegisterNameController extends GetxController {
  RxString customerName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    //debounce(username, validations, time: Duration(milliseconds: 500));
  }

  void getName(String val) {
    customerName.value = val;
    print(customerName.value);
  }
}
