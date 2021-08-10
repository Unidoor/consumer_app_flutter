// To parse this JSON data, do
//
//     final countryCodeModel = countryCodeModelFromJson(jsonString);

import 'dart:convert';

CountryCodeModel countryCodeModelFromJson(String str) =>
    CountryCodeModel.fromJson(json.decode(str));

String countryCodeModelToJson(CountryCodeModel data) =>
    json.encode(data.toJson());

class CountryCodeModel {
  CountryCodeModel({
    this.message,
    this.status,
    this.data,
  });

  String message;
  bool status;
  List<Datum> data;

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) =>
      CountryCodeModel(
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
    this.countryId,
    this.name,
    this.intlCode,
    this.flagImageUrl,
  });

  dynamic countryId;
  String name;
  String intlCode;
  String flagImageUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        countryId: json["countryId"],
        name: json["name"],
        intlCode: json["intlCode"],
        flagImageUrl: json["flagImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "countryId": countryId,
        "name": name,
        "intlCode": intlCode,
        "flagImageUrl": flagImageUrl,
      };
}
