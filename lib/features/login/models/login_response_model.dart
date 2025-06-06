import 'dart:convert';

LoginResponseModel LoginResponseFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  bool? success;
  String? message;
  Data? data;
  String? error;
  DateTime? timestamp;

  LoginResponseModel({
    this.success,
    this.message,
    this.data,
    this.error,
    this.timestamp,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        error: json["error"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

}

class Data {
  String? token;
  String? name;

  Data({
    this.token,
    this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
      };
}
