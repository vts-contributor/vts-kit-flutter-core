import 'package:flutter/material.dart';
import 'package:flutter_core/extensions/validation/date_time.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_validation_test.dart';

class DateTimeValidationTest extends BaseValidationTest {
  @override
  String get name => "DateTime";
  @override
  void start() {
    testEquals();
    testRange();
  }

  void testEquals() {
    DateTime a = DateTime(2022, 11, 28, 14, 17, 22, 10, 10).toUtc();
    DateTime b = DateTime(2022, 11, 28, 14, 17, 22, 10, 10).toLocal();
    DateTime c = DateTime(2021, 11, 27, 13, 7, 2, 1, 1).toLocal();

    expect(a.equalsDate(b), true, reason: "DateTime a must equals DateTime b in: d/m/y");
    expect(a.equalsDate(c), false, reason: "DateTime a must not equals DateTime c in: d/m/y");
    expect(a.equals(b,
      day: true,
      month: true,
      year: true,
      hour: true,
      minute: true,
      second: true,
      millisecond: true,
      microsecond: true,
    ), true, reason: "DateTime a must equals DateTime b");
    expect(a.equals(c,
      day: true,
      month: true,
      year: true,
      hour: true,
      minute: true,
      second: true,
      millisecond: true,
      microsecond: true,
    ), false, reason: "DateTime a must not equals DateTime c");
  }

  void testRange() {
    DateTime root = _createDate(16, 23);

    DateTime checkAfter1 = _createDate(16, 52);
    DateTime checkAfter2 = _createDate(16, 53);
    DateTime checkAfter3 = _createDate(16, 54);

    expect(checkAfter1.isInDurationAfter(root, Duration(minutes: 30)), true);
    expect(checkAfter2.isInDurationAfter(root, Duration(minutes: 30), true), false);
    expect(checkAfter2.isInDurationAfter(root, Duration(minutes: 30), false), true);
    expect(checkAfter3.isInDurationAfter(root, Duration(minutes: 30)), false);

    DateTime checkBefore1 = _createDate(15, 54);
    DateTime checkBefore2 = _createDate(15, 53);
    DateTime checkBefore3 = _createDate(15, 52);

    //test before
    expect(checkBefore1.isInDurationBefore(root, Duration(minutes: 30)), true);
    expect(checkBefore2.isInDurationBefore(root, Duration(minutes: 30), true), false);
    expect(checkBefore2.isInDurationBefore(root, Duration(minutes: 30), false), true);
    expect(checkBefore3.isInDurationBefore(root, Duration(minutes: 30)), false);

    //test apart
    expect(checkAfter1.isInDurationApartFrom(root, Duration(minutes: 30)), true);
    expect(checkAfter2.isInDurationApartFrom(root, Duration(minutes: 30), false, true), false);
    expect(checkAfter2.isInDurationApartFrom(root, Duration(minutes: 30), false, false), true);
    expect(checkAfter3.isInDurationApartFrom(root, Duration(minutes: 30)), false);
    expect(checkBefore1.isInDurationApartFrom(root, Duration(minutes: 30)), true);
    expect(checkBefore2.isInDurationApartFrom(root, Duration(minutes: 30), true, false), false);
    expect(checkBefore2.isInDurationApartFrom(root, Duration(minutes: 30), false, false), true);
    expect(checkBefore3.isInDurationApartFrom(root, Duration(minutes: 30)), false);

    //test between
  }

  static DateTime _createDate(int hour, int minute) {
    var year = 2022, month = 11, day = 18, second = 20, mils = 30, mics = 40;
    return DateTime(year, month, day, hour, minute, second, mils, mics);
  }
}

class TimeOfDayValidationTest extends BaseValidationTest {
  @override
  String get name => "TimeOfDay";

  @override
  void start() {

    expect(TimeOfDay(hour: 12, minute: 12).equals(TimeOfDay(hour: 12, minute: 12)), true);
    expect(TimeOfDay(hour: 12, minute: 12).equals(TimeOfDay(hour: 12, minute: 13)), false);

    expect(TimeOfDay(hour: 11, minute: 59).isDay, true);
    expect(TimeOfDay(hour: 12, minute: 00).isDay, false);
    expect(TimeOfDay(hour: 12, minute: 01).isDay, false);

    expect(TimeOfDay(hour: 23, minute: 59).isNight, true);
    expect(TimeOfDay(hour: 0, minute: 00).isNight, false);
    expect(TimeOfDay(hour: 0, minute: 01).isNight, false);
  }

}