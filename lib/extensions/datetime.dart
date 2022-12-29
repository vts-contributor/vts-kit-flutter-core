//////////////////////// Constant ///////////////////////////

const int timeNotCheck = -1;
const int timeInvalid = 0;
const int timeValid = 1;

// string format
const String defaultDateFormat = "yyyy-MM-dd HH:mm:ss";
const String defaultDateFormat2 = 'dd/MM/yyyy HH:mm';
const String defaultDateFormat3 = 'dd/MM/yyyy';
const String dateFormatAttendance = 'yyyy-MM-dd HH:mm';
const String dateOnlyFormat = 'yyyy-MM-dd';
const String dateFormatDatePayReceived = 'ddMMyy';
const String dateTimeFormatVN = 'dd/MM/yyyy HH:mm:ss';
const String timeOnlyFormat = 'HH:mm:ss';
const String dateFormatFileExport = 'yyyyMMddHHmmss';

// maximum of time variance
const int maxTimeWrong = 10;
const int rightTime = 0;
const int wrongDate = 1;
const int wrongTime = 2;
const int wrongTimeBootReason = 3;

//////////////////////////////////////////////////////////////

// Convert unformatted DateTime string to defaultDateFormat
// Note: Only handle defaultDateFormat2, defaultDateFormat3, dateTimeFormatVN and right format
// Note: Do not accept timeOnlyFormat, dateFormatDatePayReceived
String formatString(String unformatted) {
  String result = unformatted;
  List<String> dateTime = unformatted.split(RegExp(r'/|:|\s|-'));
  if (dateTime.length >= 3) {
    if (dateTime[0].length == 2) {
      String temp = dateTime[0];
      dateTime[0] = dateTime[2];
      dateTime[2] = temp;
    }
    result =
    "${dateTime[0]}-${dateTime[1]}-${dateTime[2]}${dateTime.length == 3 ? '' : ' ${dateTime[3]}'}";
  }
  for (int i = 4; i < dateTime.length; i++) {
    result += ':${dateTime[i]}';
  }
  return result;
}

// Get string format of time element
String getStringofTime(int time) {
  String result = '$time';
  if ((time / 10).floor() == 0) {
    result = '0$time';
  }
  return result;
}

extension DateTimeUtils on DateTime {
  // Check if the date is Sunday
  bool isSunday() {
    return weekday == DateTime.sunday;
  }

  // Convert date to a specified format
  String convertDateTimeWithFormat(String format) {
    String result = '';
    int i = 0;
    while (i < format.length) {
      switch (format[i]) {
        case 'y':
          if (i + 2 < format.length) {
            if (format[i + 2] == 'y') {
              result += getStringofTime(year);
            } else {
              result += getStringofTime(year % 100);
            }
          } else {
            result += getStringofTime(year % 100);
          }
          i += 4;
          break;
        case 'M':
          result += getStringofTime(month);
          i += 2;
          break;
        case 'd':
          result += getStringofTime(day);
          i += 2;
          break;
        case 'H':
          result += getStringofTime(hour);
          i += 2;
          break;
        case 'm':
          result += getStringofTime(minute);
          i += 2;
          break;
        case 's':
          result += getStringofTime(second);
          i += 2;
          break;
        default:
          result += format[i];
          i += 1;
      }
    }
    return result;
  }

  // Get days of week in Vietnamese
  String getDayOfWeek() {
    String dayOfWeek = '';
    switch (weekday) {
      case 1:
        dayOfWeek = 'Thứ 2';
        break;
      case 2:
        dayOfWeek = 'Thứ 3';
        break;
      case 3:
        dayOfWeek = 'Thứ 4';
        break;
      case 4:
        dayOfWeek = 'Thứ 5';
        break;
      case 5:
        dayOfWeek = 'Thứ 6';
        break;
      case 6:
        dayOfWeek = 'Thứ 7';
        break;
      case 7:
        dayOfWeek = 'Chủ Nhật';
        break;
    }
    return dayOfWeek;
  }

  // Check if the arrival date is less than or equal to 30 min.
  bool isIn30Min(DateTime date) {
    DateTime after30 = add(const Duration(minutes: 30));
    return date.isBefore(after30) || date == after30;
  }

  // Check if the arrival String is less than or equal to 30 min.
  // Note: Sqlite date time string is acceptable
  bool isIn30MinFromString(String dateString) {
    DateTime date;
    bool result = false;
    try {
      date = DateTime.parse(formatString(dateString));
      result = isIn30Min(date);
    } catch (e) {
      print(e);
    }
    return result;
  }

  // Check whether the year is leap
  bool isLeapYear() {
    bool result = false;
    if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
      result = true;
    }
    return result;
  }

  // Get the amount of passed weeks in a year from a date
  // Note: A week starts at Monday
  // Note: Calculate the first week separately from the other.
  int passedWeeks() {
    int daysLeftOfFirstWeek = 7 - DateTime(year, 1, 1).weekday + 1;
    int days = day - daysLeftOfFirstWeek;
    for (int i = 1; i < month; i++) {
      if (i <= 7) {
        if (i == 2) {
          days += isLeapYear() ? 29 : 28;
        } else {
          days += i % 2 == 0 ? 30 : 31;
        }
      } else {
        days += i % 2 == 0 ? 31 : 30;
      }
    }
    return (days / 7).ceil() + 1;
  }

  // Calculate workdays between 2 dates
  // Note: If the other dates is before the current date, the other date is the beginning.
  int workdays(DateTime other) {
    int latestSunday;
    int firstSunday;
    if (isBefore(other)) {
      latestSunday = other.weekday;
      firstSunday = 7 - weekday;
    } else {
      firstSunday = 7 - other.weekday;
      latestSunday = weekday;
    }
    int result = difference(other).inDays.abs();
    int amountOfSundays = ((result - firstSunday - latestSunday) / 7).floor();
    result -= amountOfSundays;
    return result;
  }

  int workdaysFromString(String other) {
    DateTime date;
    int result = 0;
    try {
      date = DateTime.parse(formatString(other));
      result = workdays(date);
    } catch (e) {
      print(e);
    }
    return result;
  }

  // If the user login after a day or longer, navigate to the login page to refresh the data.
  // Use with server date
  // Worthy ??
  bool checkTimeToShowLogin() {
    return difference(DateTime.now()).inDays >= 1;
  }

  // lay ngay dau tien cua so thang truoc
  String getFirstDateOfNumberPreviousMonthWithFormat(
      String format, int numberPreviousMonth) {
    int m = month, y = year;
    m -= numberPreviousMonth;
    if (m <= 0) {
      m = m.abs();
      y -= (m / 12).ceil();
      m = 12 - (m % 12);
      if (y < 0) {
        throw Exception(['Số tháng truy vấn lớn hơn thời điểm hiện tại']);
      }
    }
    return DateTime(y, m, 1).convertDateTimeWithFormat(format);
  }

  // lay ngay cuoi cung cua so thang truoc
  String getLastDateOfNumberPreviousMonthWithFormat(
      String format, int numberPreviousMonth) {
    int m = month, y = year;
    m -= numberPreviousMonth;
    if (m <= 0) {
      m = m.abs();
      y -= (m / 12).ceil();
      m = 12 - (m % 12);
      if (y < 0) {
        throw Exception(['Số tháng truy vấn lớn hơn thời điểm hiện tại']);
      }
    }
    // Get the last day of month
    int d = 31;
    if (m <= 7) {
      if (m == 2) {
        d = isLeapYear() ? 29 : 28;
      } else {
        d = m % 2 == 0 ? 30 : 31;
      }
    } else {
      d = m % 2 == 0 ? 31 : 30;
    }

    return DateTime(y, m, d).convertDateTimeWithFormat(format);
  }

  // compareTo method with dateString
  int compareToString(String unformatted) {
    int result = 0;
    DateTime date;
    try {
      date = DateTime.parse(formatString(unformatted));
      result = compareTo(date);
    } catch (e) {
      print(e);
    }
    return result;
  }

  bool isGMT7TimeZone() {
    return timeZoneOffset.inHours == 7;
  }

  DateTime getStartDateOfMonth() {
    return DateTime(year, month, 1);
  }

  DateTime getStartTimeOfDay() {
    return DateTime(year, month, day);
  }

  int getMinutesFromAnotherDate(DateTime date) {
    int result = 0;
    result = difference(date).inMinutes.abs();
    return result;
  }

  int getMinutesFromAnotherDateFromString(String unformatted) {
    int result = 0;
    DateTime date;
    try {
      date = DateTime.parse(formatString(unformatted));
      result = getMinutesFromAnotherDate(date);
    } catch (e) {
      print(e);
    }
    return result;
  }

  String getTomorrowWithFormat(String format) {
    DateTime tomorrow = add(const Duration(days: 1));
    return tomorrow.convertDateTimeWithFormat(format);
  }

  String getYesterdayWithFormat(String format) {
    DateTime tomorrow = add(const Duration(days: -1));
    return tomorrow.convertDateTimeWithFormat(format);
  }

  // Check the response of the server with the client
  int checkServerClient(DateTime server) {
    int valid = timeNotCheck;
    // neu gio cach biet nhau 1 h -> fail
    // neu ngay khac ngay hien tai -> fail
    if (server.day != day || difference(server).inHours >= 1) {
      valid = timeInvalid;
      print('Time invalid');
    } else {
      valid = timeValid;
    }
    return valid;
  }

  int checkServerClientFromString(String server) {
    int valid = timeNotCheck;
    try {
      DateTime date = DateTime.parse(formatString(server));
      valid = checkServerClient(date);
    } catch (e) {
      print(e);
    }
    return valid;
  }
}
