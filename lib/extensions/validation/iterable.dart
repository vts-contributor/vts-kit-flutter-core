import 'package:flutter_core/extensions/extensions.dart';

extension IterableValidation<T> on Iterable<T> {

  ///Validate all values<br>
  ///Pass empty (or not) [errorValues] to pick up error ones (added to the end).
  bool validateAll(bool Function(T element) test, {List<T>? errorValues}) {
    bool result = true;
    this.forEach((element) {
      if (!test(element)) {
        errorValues?.add(element);
        result = false;
      }
    });
    return result;
  }
}