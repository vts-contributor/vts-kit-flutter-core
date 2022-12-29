import 'package:flutter/material.dart';
import 'package:flutter_core/extensions/extensions.dart';

extension DateTimeValidation on DateTime {

  ///this only compares Day, Month, Year
  bool equalsDate(DateTime other) {
    return equals(other,
      year: true,
      month: true,
      day: true
    );
  }

  /// compare DateTime base on flags.
  /// <br>default is Day Month Year <br>
  /// ex: see [equalsDate]
  bool equals(DateTime other, {bool year = true,
    bool month = true,
    bool day = true,
    bool hour = false,
    bool minute = false,
    bool second = false,
    bool millisecond = false,
    bool microsecond = false
  }) {
    final utcThis = this.toUtc();
    other = other.toUtc();

    return (year? utcThis.year == other.year: true)
      && (month? utcThis.month == other.month: true)
      && (day? utcThis.day == other.day: true)
      && (hour? utcThis.hour == other.hour: true)
      && (minute? utcThis.minute == other.minute: true)
      && (second? utcThis.second == other.second: true)
      && (millisecond? utcThis.millisecond == other.millisecond: true)
      && (microsecond? utcThis.microsecond == other.microsecond: true)
    ;
  }

  ///validate if this is in range of ([date] - [duration], [date] + [duration])
  bool isInDurationApartFrom(DateTime date, Duration duration, [bool lowerBoundExclusive = false,
    bool upperBoundExclusive = false,
  ]) {
    return isInDurationAfter(date, duration, upperBoundExclusive)
        && isInDurationBefore(date, duration, lowerBoundExclusive);
  }

  ///validate if this is before [date] + [duration]
  ///ex: isInDurationAfter(DateTime.now(), Duration(minute: 30))
  ///   => validate if this is in 30 minutes from now
  bool isInDurationAfter(DateTime date, Duration duration, [bool exclusive = false]) {
    DateTime dateAfterDuration = date.add(duration);
    return this._isBefore(dateAfterDuration, exclusive);
  }

  ///validate if this is before [date] - [duration]
  ///ex: isInDurationBefore(DateTime.now(), Duration(minute: 30))
  ///   => validate if this isn't over 30 minutes ago
  bool isInDurationBefore(DateTime date, Duration duration, [bool exclusive = false]) {
    DateTime dateBeforeDuration = date.subtract(duration);
    return this._isAfter(dateBeforeDuration, exclusive);
  }

  ///date1 and date2 positions are not matter
  bool isInRange(DateTime date1, DateTime date2, {bool lowerBoundExclusive = true,
    bool upperBoundExclusive = true
  }) {
    DateTime lowerBound, upperBound;
    if (date2.isAfter(date1)) {
      lowerBound = date1;
      upperBound = date2;
    } else {
      lowerBound = date2;
      upperBound = date1;
    }

    return this._isAfter(lowerBound, lowerBoundExclusive)
        && this._isBefore(upperBound, upperBoundExclusive);
  }

  bool isBeforeInclusive(DateTime other) {
    return _isBefore(other, false);
  }

  bool isAfterInclusive(DateTime other) {
    return _isAfter(other, false);
  }

  bool _isBefore(DateTime other,[bool exclusive = true]) {
    return this.isBefore(other) || (exclusive? false: other.isAtSameMomentAs(this));
  }

  bool _isAfter(DateTime other,[bool exclusive = true]) {
    return this.isAfter(other) || (exclusive? false: other.isAtSameMomentAs(this));
  }
}

extension TimeOfDayValidation on TimeOfDay {
  bool equals(TimeOfDay other, {
    bool hour = true,
    bool minute = true,
  }) {

    return (hour? this.hour == other.hour: true)
        && (minute? this.minute == other.minute: true);
  }

  bool get isDay {
    return this.period == DayPeriod.am;
  }

  bool get isNight {
    return this.period == DayPeriod.pm;
  }
}