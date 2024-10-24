class ServerException {
  ServerException({
    this.message,
    this.data,
  });

  ServerException.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'];
  }

  String? message;
  dynamic data;

  ServerException copyWith({
    String? message,
    dynamic data,
  }) =>
      ServerException(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['data'] = data;
    return map;
  }
}
