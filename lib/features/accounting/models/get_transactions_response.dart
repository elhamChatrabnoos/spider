import 'dart:convert';

class GetTransactionsResponse {
  bool? success;
  String? message;
  Data? data;
  dynamic error;
  DateTime? timestamp;

  GetTransactionsResponse({
    this.success,
    this.message,
    this.data,
    this.error,
    this.timestamp,
  });

  factory GetTransactionsResponse.fromRawJson(String str) =>
      GetTransactionsResponse.fromJson(json.decode(str));

  factory GetTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      GetTransactionsResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        error: json["error"],
        timestamp: DateTime.parse(json["timestamp"]),
      );
}

class Data {
  List<Transaction>? invoices;
  int? all;

  Data({
    this.invoices,
    this.all,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        invoices: List<Transaction>.from(
            json["invoices"].map((x) => Transaction.fromJson(x))),
        all: json["all"],
      );
}

class Transaction {
  String? id;
  int? amount;
  User? user;
  Cause? cause;
  String? type;
  String? date;
  String? time;

  Transaction({
    this.id,
    this.amount,
    this.user,
    this.cause,
    this.type,
    this.date,
    this.time,
  });

  factory Transaction.fromRawJson(String str) =>
      Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["_id"],
        amount: json["amount"],
        user: User.fromJson(json["user"]),
        cause: Cause.fromJson(json["cause"]),
        type: json["type"],
        date: json['date'],
        time: json['time'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amount": amount,
        "user": user?.toJson(),
        "cause": cause?.toJson(),
        "type": type,
      };
}

class Cause {
  String? id;
  String? causes;

  Cause({
    this.id,
    this.causes,
  });

  factory Cause.fromRawJson(String str) => Cause.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cause.fromJson(Map<String, dynamic> json) => Cause(
        id: json["_id"],
        causes: json["causes"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "causes": causes,
      };
}

class User {
  String? id;
  String? name;

  User({
    this.id,
    this.name,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
