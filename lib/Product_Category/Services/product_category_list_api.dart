import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unidoor_ecommerce/Product_Category/Models/product_category_list_models.dart';

class ProductCategoryList {
  static Future<List<Datum>> getProductCategoryList() async {
    String categoryId = "";
    int pageNumber = 0;
    int pageSize = 0;
    String sellerId = "60e93f91f2fa4a0224983f2c";

    String baseUrl = "https://unidoor-backend.herokuapp.com/";
    String url = baseUrl + "seller/" + sellerId + "products";
    print("request Url = $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      ProductCategoryList productCategoryList =
          ProductCategoryList.fromJson(jsonResponse);
      return productCategoryList.data;
    } else {
      return null;
    }
  }
}
