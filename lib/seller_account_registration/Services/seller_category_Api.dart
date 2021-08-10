import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unidoor_ecommerce/seller_account_registration/Models/seller_category_model.dart';

class SellerCategory {
  static Future<List<Datum>> getSellerCategory() async {
    String baseUrl = "https://unidoor-backend.herokuapp.com/";
    String url = baseUrl + "seller/category";

    final response = await http.get(Uri.parse(url));
    print(response.body);

    var jsonResponse = json.decode(response.body);
    print("json response first : ${jsonResponse}");
    SellerCategoryModel sellerCategoryModel =
        new SellerCategoryModel.fromJson(jsonResponse);

    print("json response : ${sellerCategoryModel.data}");
    return sellerCategoryModel.data;
    // return jsonResponse
    //     .map((item) => new CountryCodeModel.fromJson(item))
    //     .toList();
  }
}
