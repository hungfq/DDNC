import 'package:ddnc_new/api/response/result.dart';

class Resource<T> {
  final Result _state;
  final T? _data;
  final String? _message;
  final int? _statusCode;

  Resource<T> copyWith({
    Result? state,
    T? data,
    String? message,
    int? statusCode,
  }) {
    return Resource(
      state: state ?? _state,
      data: data ?? _data,
      message: message ?? _message,
      statusCode: statusCode ?? _statusCode,
    );
  }

  Resource({required state, data, message, statusCode})
      : _state = state,
        _data = data,
        _message = message,
        _statusCode = statusCode;

  static Resource<T> success<T>(T data) =>
      Resource(state: Result.success, data: data);

  static Resource<T> error<T>(String errorMsg, int statusCode, [T? data]) =>
      Resource(
          state: Result.error,
          data: data,
          message: errorMsg,
          statusCode: statusCode);

  static Resource<T> loading<T>({T? data}) => Resource(
        state: Result.loading,
        data: data,
      );

  Result get state => _state;

  T? get data => _data;

  String? get message => _message;

  int? get statusCode => _statusCode;
}
