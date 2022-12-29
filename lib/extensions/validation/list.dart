import 'dart:collection';

extension ListValidation<T> on List<T> {

  ///Validate all values<br>
  ///Pass empty (or not) [errorValues] or [errorIndexes] to pick up error ones (added to the end).
  ///This
  bool validateAll(bool Function(T element) test, {List<T>? errorValues,
    List<int>? errorIndexes,
  }) {
    int i = 0;
    bool result = true;

    for (T element in this) {
      if (!test(element)) {
        errorValues?.add(element);
        errorIndexes?.add(i);
        result = false;
      }

      i++;
    }

    return result;
  }
}