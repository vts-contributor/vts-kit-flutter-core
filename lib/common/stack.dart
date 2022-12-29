import 'package:flutter_core/extensions/extension_functions.dart';

class Stack<E> {
  final _list = <E>[];

  void push(E value) {
    _list.add(value);
  }

  E? pop() {
    return _list.takeIf((it) => it.isNotEmpty)?.removeLast();
  }

  E? get peek => _list.takeIf((it) => it.isNotEmpty)?.last;

  bool get isEmpty => _list.isEmpty;

  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
