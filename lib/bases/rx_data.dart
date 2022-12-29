class RxData<T> {
  final Status status;
  final T? data;
  final Exception? error;

  RxData._(this.status, this.data, this.error);

  factory RxData.init() => RxData._(Status.INIT, null, null);

  factory RxData.loading() => RxData._(Status.LOADING, null, null);

  factory RxData.succeed(T data) {
    if (data == null ||
        (data is List && data.isEmpty) ||
        (data is Map && data.isEmpty)) {
      return RxData.empty();
    }
    return RxData._(Status.SUCCEED, data, null);
  }

  factory RxData.empty() => RxData._(Status.EMPTY, null, null);

  factory RxData.failed(dynamic error) {
    if (error is Exception) {
      return RxData._(Status.FAILED, null, error);
    } else {
      return RxData._(Status.FAILED, null, Exception('$error'));
    }
  }

  @override
  String toString() => '$status, $data, $error';
}

enum Status { INIT, LOADING, SUCCEED, EMPTY, FAILED }
