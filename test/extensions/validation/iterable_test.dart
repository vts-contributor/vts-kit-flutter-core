import 'package:flutter_core/extensions/extensions.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_validation_test.dart';

class IterableValidationTest extends BaseValidationTest {
  @override
  String get name => "Iterable";

  void testValidateAll() {
    Set<String> set = Set();
    set..add("v1")..add("v2")..add("v3")..add("v4");

    expect(set.validateAll((e) => e.isNotEmpty), true);

    List<String> errorValues = [];

    expect(set.validateAll((element) => element == "v3",
      errorValues: errorValues,
    ), false);
    expect(errorValues[0] == "v1", true);
    expect(errorValues[1] == "v2", true);
    expect(errorValues[2] == "v4", true);
  }
  @override
  void start() {
    testValidateAll();
  }
}