// To parse this JSON data, do
//
//     final getOtpModel = getOtpModelFromJson(jsonString);

import 'dart:convert';

GetOtpModel getOtpModelFromJson(String str) =>
    GetOtpModel.fromJson(json.decode(str));

String getOtpModelToJson(GetOtpModel data) => json.encode(data.toJson());

class GetOtpModel {
  GetOtpModel({
    this.message,
    this.status,
    this.data,
  });

  String message;
  bool status;
  Data data;

  factory GetOtpModel.fromJson(Map<String, dynamic> json) => GetOtpModel(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.otpCode,
    this.identifier,
  });

  String otpCode;
  String identifier;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        otpCode: json["otpCode"],
        identifier: json["identifier"],
      );

  Map<String, dynamic> toJson() => {
        "otpCode": otpCode,
        "identifier": identifier,
      };
}
