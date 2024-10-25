class ServerResponse {
  ServerResponse({
    this.success,
    this.data,
    this.error,
    this.scope,
  });

  ServerResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'];
    error = json['error'];
    scope = json['scope'];
  }

  bool? success;
  dynamic data;
  String? error;
  String? scope;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['data'] = data;
    map['error'] = error;
    map['scope'] = scope;
    return map;
  }
}
