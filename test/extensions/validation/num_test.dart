import 'package:flutter_core/extensions/validation/num.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_validation_test.dart';

class NumValidationTest extends BaseValidationTest {
  void testInRange() {
    final lowerBound = -2.99999999999999;
    final upperBound = 2.99999999999999;

    expect((-3).isInRange(lowerBound, upperBound), false);

    //1 more 9
    expect((-2.999999999999999).isInRange(lowerBound, upperBound, lowerExclusive: false), false);

    expect(lowerBound.isInRange(lowerBound, upperBound,
      lowerExclusive: true,
    ), false);
    expect(lowerBound.isInRange(lowerBound, upperBound,
      lowerExclusive: false,
    ), true);

    expect((0).isInRange(lowerBound, upperBound), true);

    expect(upperBound.isInRange(lowerBound, upperBound,
      upperExclusive: true,
    ), false);

    expect(upperBound.isInRange(lowerBound, upperBound,
      upperExclusive: false,
    ), true);

    //1 more 9
    expect((2.999999999999999).isInRange(lowerBound, upperBound, upperExclusive: false), false);
    expect((3).isInRange(lowerBound, upperBound), false);

  }
  @override
  String get name => "Num";
  @override
  void start() {
    testInRange();
  }
}