import 'package:flutter_core/extensions/validation/map.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_validation_test.dart';

class MapValidationTest extends BaseValidationTest {
  void testValidateAll() {
    Map<String, String> map1 = _createStringStringMap();

    expect(map1.validateAll((value) => value.isNotEmpty), true);

    List<String> errorValues = [];
    List<String> errorKeys = [];

    expect(map1.validateAll((value) => value == "value3",
      errorKeys: errorKeys,
      errorValues: errorValues,
    ), false);

    expect(errorKeys.contains("v1"), true);
    expect(errorKeys.contains("v2"), true);
    expect(errorKeys.contains("v3"), false);
    expect(errorKeys.contains("v4"), true);

    expect(errorValues.contains("value1"), true);
    expect(errorValues.contains("value2"), true);
    expect(errorValues.contains("value3"), false);
    expect(errorValues.contains("value4"), true);
  }

  Map<String, String> _createStringStringMap() {
    Map<String, String> map = Map();
    map.putIfAbsent("v1", () => "value1");
    map.putIfAbsent("v2", () => "value2");
    map.putIfAbsent("v3", () => "value3");
    map.putIfAbsent("v4", () => "value4");

    return map;
  }

  void testContainsPair() {
    Map<String, String> map = _createStringStringMap();

    expect(map.containsPair("v3", "value3"), true);
    expect(map.containsPair("v2", "value3"), false);
    expect(map.containsPair("v3", "other"), false);
    expect(map.containsPair("other", "value3"), false);

  }
  @override
  String get name => "Map";
  @override
  void start() {
    testValidateAll();
    testContainsPair();
  }
}