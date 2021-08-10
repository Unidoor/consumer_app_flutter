import 'package:get/get.dart';
import 'package:unidoor_ecommerce/LoginScreen/Models/get_otp_model.dart';
import 'package:unidoor_ecommerce/services/get_otp_api_manager.dart';

class OtpController extends GetxController {
  var otpValue = RxList<Data>().obs;

  List<String> otpVerification = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    fetchOtp(otpVerification);
  }

  void fetchOtp(List otpVerification) async {
    print("fetch method called");
    var getOtpList = await GetOtpApiManager.getOtp(otpVerification.toString());

    if (getOtpList != null) {
      otpValue.value.add(getOtpList);
      print("otp Value = ${otpValue.value}");
      print("getOtpList = $getOtpList");
    }
    // print("country code List :$countryCodeList");
    // for (Data data in getOtpList) {
    //   otpValue.value.add(data);
    // }
    print("OTP Value = ${otpValue.value}");
    // if (countryCodeList != null) {
    //   countryCode.value = countryCodeList;
    //   print("countryCode = ${countryCode}");
    // }
  }
}
