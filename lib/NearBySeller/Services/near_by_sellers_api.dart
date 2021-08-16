import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unidoor_ecommerce/NearBySeller/Models/near_by_seller_models.dart';

class NearBySellersApi {
  static Future<List<Datum>> getNearBySeller() async {
    int bufferInKM = 7;
    // double lat = 12.562244730306842;
    // double long = 74.95255538729042;
    SharedPreferences currentLocationStorage =
        await SharedPreferences.getInstance();
    var currentLocationLat =
        currentLocationStorage.getString('currentLocationLat');
    var currentLocationLong =
        currentLocationStorage.getString('currentLocationLong');
    double lat = double.parse("$currentLocationLat");
    double long = double.parse("$currentLocationLong");
    print("current latitude:$lat current longitude: $long ");
    String baseUrl = "https://unidoor-backend.herokuapp.com/";
    String url = baseUrl + "seller?bufferInKM=$bufferInKM&lat=$lat&lng=$long";
    print("Request is = $url");
    final response = await http.get(Uri.parse(url));
    // print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      print("json response first : success");
      NearBySeller nearBySeller = new NearBySeller.fromJson(jsonResponse);
      // var jsonResponse = response.body;
      return nearBySeller.data;
    } else {
      return null;
    }
  }
}
