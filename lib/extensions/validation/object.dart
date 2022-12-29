extension ObjectValidation on Object? {
  bool get isNull {
    return this == null;
  }

  bool get isNotNull {
    return !isNull;
  }

  bool isInMap(Map<dynamic, dynamic> map) {
    return map.containsValue(this);
  }

  bool isInIterable(Iterable<dynamic> iterable) {
    return iterable.contains(this);
  }


  ///support Map, List, Set and their super classes like SplayTreeSet...
  bool isIn(dynamic values) {
    if (values == null ) {
      return false;
    }

    if (values is Map) {
      return isInMap(values);
    }

    if (values is Iterable) {
      return isInIterable(values);
    }

    return false;
  }

}
