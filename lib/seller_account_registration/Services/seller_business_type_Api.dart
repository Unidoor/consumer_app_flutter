import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unidoor_ecommerce/seller_account_registration/Models/seller_business_type_model.dart';
// import 'file:///Users/unilog/Documents/ashique/UniDoor/consumer_app_flutter_bur/lib/seller_account_registration/Models/seller_business_type_model.dart';

class SellerBusinessType {
  static Future<List<Datum>> getSellerBusinessType() async {
    String baseUrl = "https://unidoor-backend.herokuapp.com/";
    String url = baseUrl + "seller/businessType";

    final response = await http.get(Uri.parse(url));
    print(response.body);

    var jsonResponse = json.decode(response.body);
    print("json response first : ${jsonResponse}");
    SellerBusinessTypeModel sellerBusinessTypeModel =
        new SellerBusinessTypeModel.fromJson(jsonResponse);

    print("json response : ${sellerBusinessTypeModel.data}");
    return sellerBusinessTypeModel.data;
    // return jsonResponse
    //     .map((item) => new CountryCodeModel.fromJson(item))
    //     .toList();
  }
}
