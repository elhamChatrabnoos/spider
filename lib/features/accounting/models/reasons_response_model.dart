// To parse this JSON data, do
//
//     final reasonsModel = reasonsModelFromJson(jsonString);

import 'dart:convert';

ReasonsResponse reasonsModelFromJson(String str) => ReasonsResponse.fromJson(json.decode(str));


class ReasonsResponse {
  bool? success;
  String? message;
  List<Reason>? data;
  String? error;
  DateTime? timestamp;

  ReasonsResponse({
    this.success,
    this.message,
    this.data,
    this.error,
    this.timestamp,
  });

  factory ReasonsResponse.fromJson(Map<String, dynamic> json) => ReasonsResponse(
    success: json["success"],
    message: json["message"],
    data: List<Reason>.from(json["data"].map((x) => Reason.fromJson(x))),
    error: json["error"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

}

class Reason {
  String? id;
  String? causes;
  List<String>? invoice;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Reason({
    this.id,
    this.causes,
    this.invoice,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
    id: json["_id"],
    causes: json["causes"],
    invoice: List<String>.from(json["invoice"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );


}
