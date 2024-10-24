abstract class ResponseStatus<T>{
  final T? data;
  final String? error;

  const ResponseStatus(this.data, this.error);
}

class ResponseSuccess<T> extends ResponseStatus<T>{
  const ResponseSuccess(T data) : super(data, null);
}

class ResponseFailed<T> extends ResponseStatus<T>{
  const ResponseFailed(String error) : super(null, error);
}