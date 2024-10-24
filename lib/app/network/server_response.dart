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
  String? data;
  String? error;
  String? scope;

  ServerResponse copyWith({
    bool? success,
    String? data,
    String? error,
    String? scope,
  }) =>
      ServerResponse(
        success: success ?? this.success,
        data: data ?? this.data,
        error: error ?? this.error,
        scope: scope ?? this.scope,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['data'] = data;
    map['error'] = error;
    map['scope'] = scope;
    return map;
  }
}
