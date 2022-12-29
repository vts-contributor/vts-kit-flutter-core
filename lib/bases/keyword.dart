import 'package:flutter/foundation.dart';

abstract class AbstractKeyword {
  static const DEFAULT_LIMIT = 10;
  int _limit = DEFAULT_LIMIT;
  int _offset = 0;
  String? _lastSearch;

  @nonVirtual
  int get limit => _limit;

  @nonVirtual
  set limit(int limit) {
    this._limit = limit;
  }

  //offset change when keyword values change, but _offset remember last search
  @nonVirtual
  int get offset {
    if (keywordToStringWithLimit() != _lastSearch) {
      return 0;
    }
    return _offset;
  }

  @nonVirtual
  set offset(dynamic offset) {
    this._offset = offset;
  }

  @nonVirtual
  void clear() {
    clearPaging();
    onClear();
  }

  void onClear();

  @mustCallSuper
  void clearPaging() {
    _offset = 0;
  }

  String keywordToStringWithLimit() => '${keywordToString()}, limit=$_limit';

  //compare current keyword values to last search keyword values
  String keywordToString();

  @nonVirtual
  Map<String, dynamic> toRequestParams() {
    final currentSearch = keywordToStringWithLimit();
    if (currentSearch != _lastSearch) {
      _offset = 0;
    }
    _lastSearch = currentSearch;
    return requestParams..addAll({'limit': _limit, 'offset': _offset});
  }

  @protected
  Map<String, dynamic> get requestParams;
}
