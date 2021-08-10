import 'package:get/get.dart';

class PhoneNumberController extends GetxController {
  RxString phoneNumber = ''.obs;
  RxString errorText = RxString(null);
  Rx<Function> submitFunc = Rx<Function>(null);

  @override
  void onInit() {
    super.onInit();
    //debounce(username, validations, time: Duration(milliseconds: 500));
  }

  void validations(String val) async {
    errorText.value = null; // reset validation errors to nothing
    // submitFunc.value = null; // disable submit while validating
    if (val.isNotEmpty) {
      // if (lengthOK(val) && await available(val)) {
      if (lengthOK(val)) {
        print('All validations passed, enable submit btn...');
        // submitFunc.value = submitFunction();
        errorText.value = null;
      }
    }
  }

  bool lengthOK(String val, {int minLen = 10}) {
    if (val.length < minLen) {
      errorText.value = 'Please enter a valid phone number';
      return false;
    }
    return true;
  }
  //
  // Future<bool> available(String val) async {
  //   print('Query availability of: $val');
  //   await Future.delayed(
  //       Duration(seconds: 1),
  //           () => print('Available query returned')
  //   );
  //
  //   if (val == "Sylvester") {
  //     errorText.value = 'Name Taken';
  //     return false;
  //   }
  //   return true;
  // }

  void phoneNumberChanged(String val) {
    phoneNumber.value = val;
    print(phoneNumber.value);
  }

  // Future<bool> Function() submitFunction() {
  //   return () async {
  //     print('Make database call to create ${username.value} account');
  //     await Future.delayed(Duration(seconds: 1), () => print('User account created'));
  //     return true;
  //   };
  // }

}
