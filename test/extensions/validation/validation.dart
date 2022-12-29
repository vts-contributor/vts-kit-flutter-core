import 'package:flutter_core/extensions/extensions.dart';
import 'package:flutter_core/extensions/validation/bool.dart';
import 'package:flutter_core/extensions/validation/num.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_validation_test.dart';
import 'date_time_test.dart';
import 'int_test.dart';
import 'iterable_test.dart';
import 'list_test.dart';
import 'map_test.dart';
import 'num_test.dart';
import 'object_test.dart';
import 'string_test.dart';

void main() {

  List<BaseValidationTest> tests = [
    ObjectValidationTest(),
    IntValidationTest(),
    DateTimeValidationTest(),
    TimeOfDayValidationTest(),
    NumValidationTest(),
    StringValidationTest(),
    MapValidationTest(),
    ListValidationTest(),
    IterableValidationTest()
  ];

  group("Validation Extensions", () {
    for (BaseValidationTest validationTest in tests) {
      test(validationTest.fullName, () => validationTest.start());
    }
  });
}