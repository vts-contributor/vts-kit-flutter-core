extension MapValidation<K, V> on Map<K, V> {
  ///Validate all values<br>
  ///Pass empty (or not) [errorKeys] or [errorValues] to pick up error ones (added to the end).
  bool validateAll(bool Function(V value) test, {List<V>? errorValues,
    List<K>? errorKeys,
  }) {
    bool result = true;
    this.forEach((key, value) {
      if (!test(value)) {
        result = false;

        errorValues?.add(value);
        errorKeys?.add(key);
      }
    });

    return result;
  }

  bool containsPair(K key, V value) {
    if (this.containsKey(key)) {
      return this[key] == value;
    } else {
      return false;
    }
  }
}