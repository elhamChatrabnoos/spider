
import 'dart:convert';

ServerResponse serverResponseFromJson(String str) => ServerResponse.fromJson(json.decode(str));

String serverResponseToJson(ServerResponse data) => json.encode(data.toJson());

class ServerResponse {
  bool? success;
  String? message;
  dynamic data;
  String? error;
  DateTime? timestamp;

  ServerResponse({
    this.success,
    this.message,
    this.data,
    this.error,
    this.timestamp,
  });

  factory ServerResponse.fromJson(Map<String, dynamic> json) => ServerResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"],
    error: json["error"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
    "error": error,
    "timestamp": timestamp?.toIso8601String(),
  };
}
