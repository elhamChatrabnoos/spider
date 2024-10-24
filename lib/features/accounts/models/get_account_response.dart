class GetAccountResponse {
  GetAccountResponse({
    this.success,
    this.data,
    this.error,
    this.scope,
  });

  GetAccountResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
    scope = json['scope'];
  }

  bool? success;
  Data? data;
  String? error;
  String? scope;

  GetAccountResponse copyWith({
    bool? success,
    Data? data,
    String? error,
    String? scope,
  }) =>
      GetAccountResponse(
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
    this.accounts,
  });

  Data.fromJson(dynamic json) {
    if (json['accounts'] != null) {
      accounts = [];
      json['accounts'].forEach((v) {
        accounts?.add(Account.fromJson(v));
      });
    }
  }

  List<Account>? accounts;

  Data copyWith({
    List<Account>? accounts,
  }) =>
      Data(
        accounts: accounts ?? this.accounts,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (accounts != null) {
      map['accounts'] = accounts?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Account {
  Account({
    this.name,
    this.password,
    this.balance,
    this.time,
  });

  Account.fromJson(dynamic json) {
    name = json['name'];
    password = json['password'];
    balance = json['balance'];
    time = json['time'];
  }

  String? name;
  String? password;
  num? balance;
  String? time;

  Account copyWith({
    String? name,
    String? password,
    num? balance,
    String? time,
  }) =>
      Account(
        name: name ?? this.name,
        password: password ?? this.password,
        balance: balance ?? this.balance,
        time: time ?? this.time,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['password'] = password;
    map['balance'] = balance;
    map['time'] = time;
    return map;
  }
}
