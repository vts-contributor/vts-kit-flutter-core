import 'package:flutter_core/extensions/validation/int.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_validation_test.dart';

class IntValidationTest extends BaseValidationTest {
  void testIsPrime() {
    final testPrimes = [2, 3, 5, 7, 11, 13, 17, 19, 1823, 2017, 2341, 4007, 4507, 5689, 6211, 7489, 7919];
    final testNotPrimes = [1, 4, 6, 8, 9, 10, 2016, 1822, 4009, 4511];

    for (var prime in testPrimes) {
      expect(prime.isPrime, true, reason: "$prime must be prime");

    }
    for (var prime in testNotPrimes) {
      expect(prime.isPrime, false, reason: "$prime must not be prime");

    }
  }

  @override
  String get name => "int";
  @override
  void start() {
    testIsPrime();
  }
}


