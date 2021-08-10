import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class UploadImageController extends GetxController {
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  File image;

  void getImage(ImageSource imageSource) async {
    final pickedfile = await ImagePicker().pickImage(source: imageSource);
    if (pickedfile != null) {
      selectedImagePath.value = pickedfile.path;
      image = File(selectedImagePath.value);

      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              "Mb";
      print("Image Path = ${selectedImagePath.value}");
    } else {
      Get.snackbar(
        'Error',
        'No image selected',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kPrimaryColor,
        colorText: kWhiteColor,
      );
    }
  }

  Future<void> submitAddress1() async {
    String url = 'https://unidoor-backend.herokuapp.com/customer';

    Map map = {
      "addressesList": [
        {
          "address": "Kumbala",
          "doorNo": "",
          "location": [12.59299918872855, 74.94415066201022]
        }
      ],
      "country": "60e2d6f150339703cc4e84e8",
      "deviceToken":
          "fMuTI4726EQVlgXMxAsKrB:APA91bGXdDiUems2Sy0oSEFMR_S3yprwJUicY11PeOJuWGTFw7KT15lxQx_yLY4rm2a4V1pPLnWWc1obVedDcnNw6Xr6nIMQafAJyGd84nRmA7Gyj3tjVc9axcd2NQc86MLVnnk1k8ob",
      "mobileNumber": "1232312313",
      "name": "Carry fresh"
    };

    var body = json.encode(map);
    // var body = map;
    // HttpClient httpClient = new HttpClient();
    // HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    // request.headers.set('content-type', 'application/json');
    // request.add(utf8.encode(json.encode(map)));
    // HttpClientResponse response = await request.close();
    // // todo - you should check the response.statusCode
    // String reply = await response.transform(utf8.decoder).join();
    try {
      String fileName = image.path.split('/').last;

      var stream = new http.ByteStream(image.openRead());
      stream.cast();
      var length = await image.length();

      var uri = Uri.parse(url);

      Map<String, String> headers = {
        "content-type": "application/json",
      };
      var request = new http.MultipartRequest("POST", uri);
      request.fields["customer"] = body;
      print(request.fields);
      request.headers.addAll(headers);

      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: basename(image.path),
          contentType: MediaType("content-type", "multipart/form-data"));
      //contentType: new MediaType('image', 'png'));

      request.files.add(multipartFile);
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print("Address submitted value :$value");
      });
    } catch (e) {
      print("error :" + e);
    }
  }

  Future<void> submitAddress() async {
    try {
      Map map = {
        "addressesList": [
          {
            "address": "Kumbala",
            "doorNo": "",
            "location": [12.59299918872855, 74.94415066201022]
          }
        ],
        "country": "60e2d6f150339703cc4e84e8",
        "deviceToken":
            "fMuTI4726EQVlgXMxAsKrB:APA91bGXdDiUems2Sy0oSEFMR_S3yprwJUicY11PeOJuWGTFw7KT15lxQx_yLY4rm2a4V1pPLnWWc1obVedDcnNw6Xr6nIMQafAJyGd84nRmA7Gyj3tjVc9axcd2NQc86MLVnnk1k8ob",
        "mobileNumber": "1232312313",
        "name": "Carry fresh"
      };
      final params = {'customer': map};
      final url = Uri.parse('https://unidoor-backend.herokuapp.com/customer');
      var response = await http.post(
        url,
        body: json.encode(params),
        headers: {'content-type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
