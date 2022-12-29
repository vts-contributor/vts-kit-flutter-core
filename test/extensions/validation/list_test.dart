import 'dart:collection';

import 'package:flutter_core/extensions/extensions.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_validation_test.dart';

class ListValidationTest extends BaseValidationTest {
  void testValidateAll() {
    List<String> list = ["v1", "v2", "v3", "v4"];

    expect(list.validateAll((e) => e.isNotEmpty), true);

    List<String> errorValues = [];
    List<int> errorIndexes = [];

    expect(list.validateAll((element) => element == "v3",
      errorValues: errorValues,
      errorIndexes: errorIndexes,
    ), false);
    expect(errorValues[0] == "v1", true);
    expect(errorValues[1] == "v2", true);
    expect(errorValues[2] == "v4", true);
    expect(errorIndexes[0] == 0, true);
    expect(errorIndexes[1] == 1, true);
    expect(errorIndexes[2] == 3, true);
  }
  @override
  String get name => "List";
  @override
  void start() {
    testValidateAll();
  }
}

