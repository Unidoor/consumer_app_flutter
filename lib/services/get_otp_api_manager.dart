import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unidoor_ecommerce/LoginScreen/Controllers/otp_conroller.dart';
import 'package:unidoor_ecommerce/LoginScreen/Models/get_otp_model.dart';

class GetOtpApiManager {
  static Future<Data> getOtp(String otpVerification) async {
    String baseUrl = "https://unidoor-backend.herokuapp.com/";
    String subUrl = baseUrl + "auth/otp?mobileNumber=$otpVerification";

    final response = await http.get(Uri.parse(subUrl));
    print(response.body);

    var jsonResponse = json.decode(response.body);
    print("json response first : ${jsonResponse}");
    // OtpController getOtpModel = new OtpController.fromJson(jsonResponse);
    GetOtpModel getOtpModelValue = new GetOtpModel.fromJson(jsonResponse);
    print("json response : ${getOtpModelValue.data}");
    return getOtpModelValue.data;
    // return jsonResponse
    //     .map((item) => new CountryCodeModel.fromJson(item))
    //     .toList();
  }
}
