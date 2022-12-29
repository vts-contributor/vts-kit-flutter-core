import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class DatetimeTextInput extends StatefulWidget {
  final String title;

  final String? hint;

  final bool require;

  final TextEditingController controller;

  final DateTime? defaultDate;

  final FocusNode? focusNode;

  const DatetimeTextInput({
    Key? key,
    required this.title,
    this.require = true,
    required this.controller,
    this.hint,
    this.defaultDate,
    this.focusNode,
  }) : super(key: key);

  @override
  State<DatetimeTextInput> createState() => _DatetimeTextInputState();
}

class _DatetimeTextInputState extends State<DatetimeTextInput> {
  void _pickDate() async {
    final initialDate = widget.controller.text.isEmpty
        ? (widget.defaultDate ?? DateTime.now())
        : Utilities().str2DateTime(widget.controller.value.text);

    DatePickerUtil().pickDate(context, initialDate: initialDate).then((value) {
      if (value != null) {
        widget.controller.text = Utilities().dateTime2String(value);
      }
    });

    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    if(widget.defaultDate != null) {
      widget.controller.text = Utilities().dateTime2String(widget.defaultDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickDate,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xffC4C4C4),
                width: 0.5,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      counterText: "",
                      labelText: widget.title,
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Image.asset(
                  "assets/right_arrow_icon.png",
                  width: 18,
                  fit: BoxFit.scaleDown,
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

class DatePickerUtil {
  Future<DateTime?> pickDate(BuildContext context,
      {DateTime? initialDate}) async {
    DateTime? date = await DatePicker.showPicker(
      context,
      showTitleActions: true,
      onChanged: (date) {},
      onConfirm: (date) {},
      locale: LocaleType.vi,
      pickerModel: CustomPickerModel(
        currentTime: initialDate,
        locale: LocaleType.vi,
      ),
    );
    return date;
  }
}

class CustomPickerModel extends CommonPickerModel {
  late DateTime maxTime;
  late DateTime minTime;

  CustomPickerModel(
      {DateTime? currentTime,
      DateTime? maxTime,
      DateTime? minTime,
      LocaleType? locale})
      : super(locale: locale) {
    this.maxTime = maxTime ?? DateTime(2049, 12, 31);
    this.minTime = minTime ?? DateTime(1970, 1, 1);

    currentTime = currentTime ?? DateTime.now();

    if (currentTime.compareTo(this.maxTime) > 0) {
      currentTime = this.maxTime;
    } else if (currentTime.compareTo(this.minTime) < 0) {
      currentTime = this.minTime;
    }

    this.currentTime = currentTime;

    _fillLeftLists();
    _fillMiddleLists();
    _fillRightLists();
    int minMonth = _minMonthOfCurrentYear();
    int minDay = _minDayOfCurrentMonth();
    super.setLeftIndex(this.currentTime.day - minDay);
    super.setMiddleIndex(this.currentTime.month - minMonth);
    super.setRightIndex(this.currentTime.year - this.minTime.year);

    // _currentLeftIndex = this.currentTime.year - this.minTime.year;
    // _currentMiddleIndex = this.currentTime.month - minMonth;
    // _currentRightIndex = this.currentTime.day - minDay;
  }

  void _fillLeftLists() {
    int maxDay = _maxDayOfCurrentMonth();
    int minDay = _minDayOfCurrentMonth();
    leftList = List.generate(maxDay - minDay + 1, (int index) {
      return '${minDay + index}${_localeDay()}';
    });
  }

  int _maxMonthOfCurrentYear() {
    return currentTime.year == maxTime.year ? maxTime.month : 12;
  }

  int _minMonthOfCurrentYear() {
    return currentTime.year == minTime.year ? minTime.month : 1;
  }

  int _maxDayOfCurrentMonth() {
    int dayCount = calcDateCount(currentTime.year, currentTime.month);
    return currentTime.year == maxTime.year &&
            currentTime.month == maxTime.month
        ? maxTime.day
        : dayCount;
  }

  int _minDayOfCurrentMonth() {
    return currentTime.year == minTime.year &&
            currentTime.month == minTime.month
        ? minTime.day
        : 1;
  }

  void _fillMiddleLists() {
    int minMonth = _minMonthOfCurrentYear();
    int maxMonth = _maxMonthOfCurrentYear();

    middleList = List.generate(maxMonth - minMonth + 1, (int index) {
      return _localeMonth(minMonth + index);
    });
  }

  void _fillRightLists() {
    rightList =
        List.generate(maxTime.year - minTime.year + 1, (int index) {
      return '${minTime.year + index}${_localeYear()}';
    });
  }

  @override
  void setLeftIndex(int index) {
    super.setLeftIndex(index);
    int minDay = _minDayOfCurrentMonth();
    currentTime = currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            minDay + index,
          )
        : DateTime(
            currentTime.year,
            currentTime.month,
            minDay + index,
          );
  }

  @override
  void setMiddleIndex(int index) {
    super.setMiddleIndex(index);
    //adjust right
    int minMonth = _minMonthOfCurrentYear();
    int destMonth = minMonth + index;
    DateTime newTime;
    //change date time
    int dayCount = calcDateCount(currentTime.year, destMonth);
    newTime = currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            destMonth,
            currentTime.day <= dayCount ? currentTime.day : dayCount,
          )
        : DateTime(
            currentTime.year,
            destMonth,
            currentTime.day <= dayCount ? currentTime.day : dayCount,
          );
    //min/max check
    if (newTime.isAfter(maxTime)) {
      currentTime = maxTime;
    } else if (newTime.isBefore(minTime)) {
      currentTime = minTime;
    } else {
      currentTime = newTime;
    }

    _fillLeftLists();
    int minDay = _minDayOfCurrentMonth();
    super.setLeftIndex(currentTime.day - minDay);
    // _currentRightIndex = currentTime.day - minDay;
  }

  @override
  void setRightIndex(int index) {
    super.setRightIndex(index);
    //adjust middle
    int destYear = index + minTime.year;
    int minMonth = _minMonthOfCurrentYear();
    DateTime newTime;
    //change date time
    if (currentTime.month == 2 && currentTime.day == 29) {
      newTime = currentTime.isUtc
          ? DateTime.utc(
              destYear,
              currentTime.month,
              calcDateCount(destYear, 2),
            )
          : DateTime(
              destYear,
              currentTime.month,
              calcDateCount(destYear, 2),
            );
    } else {
      newTime = currentTime.isUtc
          ? DateTime.utc(
              destYear,
              currentTime.month,
              currentTime.day,
            )
          : DateTime(
              destYear,
              currentTime.month,
              currentTime.day,
            );
    }
    //min/max check
    if (newTime.isAfter(maxTime)) {
      currentTime = maxTime;
    } else if (newTime.isBefore(minTime)) {
      currentTime = minTime;
    } else {
      currentTime = newTime;
    }

    _fillMiddleLists();
    _fillLeftLists();
    minMonth = _minMonthOfCurrentYear();
    int minDay = _minDayOfCurrentMonth();
    super.setMiddleIndex(currentTime.month - minMonth);
    super.setLeftIndex(currentTime.day - minDay);
    // _currentMiddleIndex = currentTime.month - minMonth;
    // _currentRightIndex = currentTime.day - minDay;
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index < leftList.length) {
      return leftList[index];
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < middleList.length) {
      return middleList[index];
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < rightList.length) {
      return rightList[index];
    } else {
      return null;
    }
  }

  String _localeYear() {
    if (locale == LocaleType.zh || locale == LocaleType.jp) {
      return '年';
    } else if (locale == LocaleType.ko) {
      return '년';
    } else {
      return '';
    }
  }

  String _localeMonth(int month) {
    if (locale == LocaleType.zh || locale == LocaleType.jp) {
      return '$month月';
    } else if (locale == LocaleType.ko) {
      return '$month월';
    } else {
      List monthStrings = i18nObjInLocale(locale)['monthLong'] as List<String>;
      return monthStrings[month - 1];
    }
  }

  String _localeDay() {
    if (locale == LocaleType.zh || locale == LocaleType.jp) {
      return '日';
    } else if (locale == LocaleType.ko) {
      return '일';
    } else {
      return '';
    }
  }

  @override
  DateTime finalTime() {
    return currentTime;
  }
}

List<int> _leapYearMonths = const <int>[1, 3, 5, 7, 8, 10, 12];

int calcDateCount(int year, int month) {
  if (_leapYearMonths.contains(month)) {
    return 31;
  } else if (month == 2) {
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
      return 29;
    }
    return 28;
  }
  return 30;
}

class Utilities {
  String dateTime2String(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    return dateFormat.format(dateTime);
  }

  DateTime str2DateTime(String strDateTime) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    return dateFormat.parse(strDateTime);
  }
}
