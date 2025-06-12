import 'dart:convert';

class TotalInfoResponse {
  bool? success;
  String? message;
  TotalInfo? data;
  String? error;
  String? timestamp;

  TotalInfoResponse({
    this.success,
    this.message,
    this.data,
    this.error,
    this.timestamp,
  });

  factory TotalInfoResponse.fromRawJson(String str) =>
      TotalInfoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TotalInfoResponse.fromJson(Map<String, dynamic> json) =>
      TotalInfoResponse(
        success: json["success"],
        message: json["message"],
        data: TotalInfo.fromJson(json["data"]),
        error: json["error"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data != null ? data!.toJson() : null,
        "error": error,
        "timestamp": timestamp,
      };
}

class TotalInfo {
  int? allExpense;
  int? hosseinExpenses;
  int? eliExpenses;
  int? balance;

  TotalInfo({
    this.allExpense,
    this.hosseinExpenses,
    this.eliExpenses,
    this.balance,
  });

  factory TotalInfo.fromRawJson(String str) => TotalInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TotalInfo.fromJson(Map<String, dynamic> json) => TotalInfo(
        allExpense: json["allExpense"],
        hosseinExpenses: json["hosseinExpenses"],
        eliExpenses: json["eliExpenses"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "allExpense": allExpense,
        "hosseinExpenses": hosseinExpenses,
        "eliExpenses": eliExpenses,
        "balance": balance,
      };
}
