import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unidoor_ecommerce/LoginScreen/Models/contry-code-model.dart';

class ApiManager {
  static Future<List<Datum>> getCountryCode() async {
    String baseUrl = "https://unidoor-backend.herokuapp.com/";
    String url = baseUrl + "countries";

    final response = await http.get(Uri.parse(url));
    print(response.body);

    var jsonResponse = json.decode(response.body);
    print("json response first : ${jsonResponse}");
    CountryCodeModel countryCodeModel =
        new CountryCodeModel.fromJson(jsonResponse);

    print("json response : ${countryCodeModel.data}");
    return countryCodeModel.data;
    // return jsonResponse
    //     .map((item) => new CountryCodeModel.fromJson(item))
    //     .toList();
  }
}
