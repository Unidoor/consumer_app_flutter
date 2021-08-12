// To parse this JSON data, do
//
//     final nearBySeller = nearBySellerFromJson(jsonString);

import 'dart:convert';

NearBySeller nearBySellerFromJson(String str) =>
    NearBySeller.fromJson(json.decode(str));

String nearBySellerToJson(NearBySeller data) => json.encode(data.toJson());

class NearBySeller {
  NearBySeller({
    this.data,
    this.message,
    this.status,
  });

  List<Datum> data;
  String message;
  bool status;

  factory NearBySeller.fromJson(Map<String, dynamic> json) => NearBySeller(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class Datum {
  Datum({
    this.address,
    this.businessType,
    this.category,
    this.country,
    this.deliveryMode,
    this.id,
    this.imageUrl,
    this.location,
    this.mobileNumber,
    this.name,
    this.open,
    this.priorityLevel,
    this.rating,
    this.totalProducts,
    this.distance,
  });

  String address;
  String businessType;
  String category;
  String country;
  String deliveryMode;
  String id;
  String imageUrl;
  List<double> location;
  String mobileNumber;
  String name;
  bool open;
  String priorityLevel;
  double rating;
  int totalProducts;
  double distance;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        address: json["address"],
        businessType: json["businessType"],
        category: json["category"],
        country: json["country"],
        deliveryMode: json["deliveryMode"],
        id: json["id"],
        imageUrl: json["imageUrl"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
        mobileNumber: json["mobileNumber"],
        name: json["name"],
        open: json["open"],
        priorityLevel: json["priorityLevel"],
        rating: json["rating"],
        totalProducts: json["totalProducts"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "businessType": businessType,
        "category": category,
        "country": country,
        "deliveryMode": deliveryMode,
        "id": id,
        "imageUrl": imageUrl,
        "location": List<dynamic>.from(location.map((x) => x)),
        "mobileNumber": mobileNumber,
        "name": name,
        "open": open,
        "priorityLevel": priorityLevel,
        "rating": rating,
        "totalProducts": totalProducts,
        "distance": distance,
      };
}
