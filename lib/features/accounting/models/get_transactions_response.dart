class GetTransactionsResponse {
  GetTransactionsResponse({
    this.success,
    this.data,
    this.error,
    this.scope,
  });

  GetTransactionsResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
    scope = json['scope'];
  }

  bool? success;
  Data? data;
  String? error;
  String? scope;

  GetTransactionsResponse copyWith({
    bool? success,
    Data? data,
    String? error,
    String? scope,
  }) =>
      GetTransactionsResponse(
        success: success ?? this.success,
        data: data ?? this.data,
        error: error ?? this.error,
        scope: scope ?? this.scope,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['error'] = error;
    map['scope'] = scope;
    return map;
  }
}

class Data {
  Data({
    this.transactions,
  });

  Data.fromJson(dynamic json) {
    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions?.add(Transaction.fromJson(v));
      });
    }
  }

  List<Transaction>? transactions;

  Data copyWith({
    List<Transaction>? transactions,
  }) =>
      Data(
        transactions: transactions ?? this.transactions,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (transactions != null) {
      map['transactions'] = transactions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Transaction {
  Transaction({
    this.account,
    this.amount,
    this.type,
    this.transActionCause,
    this.time,
  });

  Transaction.fromJson(dynamic json) {
    account = json['account'];
    amount = json['amount'];
    type = json['Type'];
    transActionCause = json['transActionCause'];
    time = json['time'];
  }

  String? account;
  num? amount;
  num? type;
  String? transActionCause;
  String? time;

  Transaction copyWith({
    String? account,
    num? amount,
    num? type,
    String? transActionCause,
    String? time,
  }) =>
      Transaction(
        account: account ?? this.account,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        transActionCause: transActionCause ?? this.transActionCause,
        time: time ?? this.time,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account'] = account;
    map['amount'] = amount;
    map['Type'] = type;
    map['transActionCause'] = transActionCause;
    map['time'] = time;
    return map;
  }
}
