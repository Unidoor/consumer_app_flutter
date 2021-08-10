// To parse this JSON data, do
//
//     final sellerCategoryModel = sellerCategoryModelFromJson(jsonString);

import 'dart:convert';

SellerCategoryModel sellerCategoryModelFromJson(String str) =>
    SellerCategoryModel.fromJson(json.decode(str));

String sellerCategoryModelToJson(SellerCategoryModel data) =>
    json.encode(data.toJson());

class SellerCategoryModel {
  SellerCategoryModel({
    this.message,
    this.status,
    this.data,
  });

  String message;
  bool status;
  List<Datum> data;

  factory SellerCategoryModel.fromJson(Map<String, dynamic> json) =>
      SellerCategoryModel(
        message: json["message"],
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.imageUrl,
  });

  String id;
  String name;
  String imageUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
      };
}
