// To parse this JSON data, do
//
//     final sellerDeliveryModeModel = sellerDeliveryModeModelFromJson(jsonString);

import 'dart:convert';

SellerDeliveryModeModel sellerDeliveryModeModelFromJson(String str) =>
    SellerDeliveryModeModel.fromJson(json.decode(str));

String sellerDeliveryModeModelToJson(SellerDeliveryModeModel data) =>
    json.encode(data.toJson());

class SellerDeliveryModeModel {
  SellerDeliveryModeModel({
    this.message,
    this.status,
    this.data,
  });

  String message;
  bool status;
  List<Datum> data;

  factory SellerDeliveryModeModel.fromJson(Map<String, dynamic> json) =>
      SellerDeliveryModeModel(
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
  });

  String id;
  String name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
