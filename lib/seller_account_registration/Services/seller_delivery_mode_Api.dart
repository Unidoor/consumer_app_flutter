import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unidoor_ecommerce/seller_account_registration/Models/seller_delivery_mode_model.dart';

class SellerDeliveryMode {
  static Future<List<Datum>> getSellerDeliveryMode() async {
    String baseUrl = "https://unidoor-backend.herokuapp.com/";
    String url = baseUrl + "seller/deliveryMode";

    final response = await http.get(Uri.parse(url));
    print(response.body);

    var jsonResponse = json.decode(response.body);
    print("json response first : ${jsonResponse}");
    SellerDeliveryModeModel sellerDeliveryModeModel =
        new SellerDeliveryModeModel.fromJson(jsonResponse);

    print("json response : ${sellerDeliveryModeModel.data}");
    return sellerDeliveryModeModel.data;
    // return jsonResponse
    //     .map((item) => new CountryCodeModel.fromJson(item))
    //     .toList();
  }
}
