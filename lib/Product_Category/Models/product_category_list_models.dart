// To parse this JSON data, do
//
//     final productCategoryList = productCategoryListFromJson(jsonString);

import 'dart:convert';

ProductCategoryList productCategoryListFromJson(String str) =>
    ProductCategoryList.fromJson(json.decode(str));

String productCategoryListToJson(ProductCategoryList data) =>
    json.encode(data.toJson());

class ProductCategoryList {
  ProductCategoryList({
    this.message,
    this.status,
    this.data,
  });

  String message;
  bool status;
  List<Datum> data;

  factory ProductCategoryList.fromJson(Map<String, dynamic> json) =>
      ProductCategoryList(
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.description,
    this.cost,
    this.strikedCost,
    this.offerPercentage,
    this.imageUrl,
    this.unit,
    this.seller,
    this.category,
    this.costCurrency,
    this.outOfStock,
  });

  String id;
  String name;
  String description;
  int cost;
  int strikedCost;
  int offerPercentage;
  String imageUrl;
  String unit;
  String seller;
  String category;
  String costCurrency;
  bool outOfStock;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        cost: json["cost"] == null ? null : json["cost"],
        strikedCost: json["strikedCost"] == null ? null : json["strikedCost"],
        offerPercentage:
            json["offerPercentage"] == null ? null : json["offerPercentage"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        unit: json["unit"] == null ? null : json["unit"],
        seller: json["seller"] == null ? null : json["seller"],
        category: json["category"] == null ? null : json["category"],
        costCurrency:
            json["costCurrency"] == null ? null : json["costCurrency"],
        outOfStock: json["outOfStock"] == null ? null : json["outOfStock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "cost": cost == null ? null : cost,
        "strikedCost": strikedCost == null ? null : strikedCost,
        "offerPercentage": offerPercentage == null ? null : offerPercentage,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "unit": unit == null ? null : unit,
        "seller": seller == null ? null : seller,
        "category": category == null ? null : category,
        "costCurrency": costCurrency == null ? null : costCurrency,
        "outOfStock": outOfStock == null ? null : outOfStock,
      };
}
