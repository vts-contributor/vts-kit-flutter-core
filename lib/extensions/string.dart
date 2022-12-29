import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

const String emptyString = "";
const String spaceString = " ";
const String replacementCharacter = "�";
const List<String> specialCharacters = [
  "‘",
  "’",
  "“",
  "”",
  "„",
  "†",
  "‡",
  "‰",
  "‹",
  "›",
  "♠",
  "♣",
  "♥",
  "♦",
  "‾",
  "←",
  "↑",
  "→",
  "↓",
  "™",
  "!",
  "“",
  "#",
  "\$",
  "%",
  "&",
  "‘",
  "(",
  ")",
  "*",
  "+",
  ",",
  "-",
  ".",
  "/",
  ":",
  ";",
  "<",
  "=",
  ">",
  "?",
  "@",
  "[",
  "\\",
  "]",
  "_",
  "`",
  "{",
  "|",
  "}",
  "~",
  "–",
  "—",
  "¡",
  "¢",
  "£",
  "¤",
  "¥",
  "¦",
  "§",
  "¨",
  "©",
  "ª",
  "«",
  "¬",
  "¬",
  "®",
  "¯",
  "°",
  "±",
  "²",
  "³",
  "´",
  "µ",
  "¶",
  "•",
  "¸",
  "¹",
  "º",
  "¿",
  "Ä",
  "Å",
  "Æ",
  "Ç",
  "Ë",
  "Î",
  "Ï",
  "Ñ",
  "Ö",
  "×",
  "Ø",
  "Û",
  "Ü",
  "Þ",
  "ß",
  "ã",
  "ä",
  "å",
  "æ",
  "ç",
  "ë",
  "î",
  "ï",
  "ð",
  "ñ",
  "õ",
  "ö",
  "÷",
  "ø",
  "û",
  "ü",
  "þ",
  "ÿ"
];
const List<String> withToneMarks = [
  'à',
  'á',
  'ả',
  'ã',
  'ạ',
  'ă',
  'ằ',
  'ắ',
  'ẳ',
  'ẵ',
  'ặ',
  'â',
  'ầ',
  'ấ',
  'ẩ',
  'ẫ',
  'ậ',
  'À',
  'Á',
  'Ả',
  'Ã',
  'Ạ',
  'Ă',
  'Ằ',
  'Ắ',
  'Ẳ',
  'Ẵ',
  'Ặ',
  'Â',
  'Ầ',
  'Ấ',
  'Ẩ',
  'Ẫ',
  'Ậ',
  'è',
  'é',
  'ẻ',
  'ẽ',
  'ẹ',
  'ê',
  'ề',
  'ế',
  'ể',
  'ễ',
  'ệ',
  'È',
  'É',
  'Ẻ',
  'Ẽ',
  'Ẹ',
  'Ê',
  'Ề',
  'Ế',
  'Ể',
  'Ễ',
  'Ệ',
  'ì',
  'í',
  'ỉ',
  'ĩ',
  'ị',
  'Ì',
  'Í',
  'Ỉ',
  'Ĩ',
  'Ị',
  'ò',
  'ó',
  'ỏ',
  'õ',
  'ọ',
  'ô',
  'ồ',
  'ố',
  'ổ',
  'ỗ',
  'ộ',
  'ơ',
  'ờ',
  'ớ',
  'ở',
  'ỡ',
  'ợ',
  'Ò',
  'Ó',
  'Ỏ',
  'Õ',
  'Ọ',
  'Ô',
  'Ồ',
  'Ố',
  'Ổ',
  'Ỗ',
  'Ộ',
  'Ơ',
  'Ờ',
  'Ớ',
  'Ở',
  'Ỡ',
  'Ợ',
  'ù',
  'ú',
  'ủ',
  'ũ',
  'ụ',
  'ư',
  'ừ',
  'ứ',
  'ử',
  'ữ',
  'ự',
  'Ù',
  'Ú',
  'Ủ',
  'Ũ',
  'Ụ',
  'ỳ',
  'ý',
  'ỷ',
  'ỹ',
  'ỵ',
  'Ỳ',
  'Ý',
  'Ỷ',
  'Ỹ',
  'Ỵ',
  'đ',
  'Đ',
  'Ư',
  'Ừ',
  'Ử',
  'Ữ',
  'Ứ',
  'Ự'
];
const List<String> withoutToneMarks = [
  'a',
  'a',
  'a',
  'a',
  'a',
  'a',
  'a',
  'a',
  'a',
  'a',
  'a',
  'a',
  'a',
  'a',
  'a',
  'a',
  'a',
  'A',
  'A',
  'A',
  'A',
  'A',
  'A',
  'A',
  'A',
  'A',
  'A',
  'A',
  'A',
  'A',
  'A',
  'A',
  'A',
  'A',
  'e',
  'e',
  'e',
  'e',
  'e',
  'e',
  'e',
  'e',
  'e',
  'e',
  'e',
  'E',
  'E',
  'E',
  'E',
  'E',
  'E',
  'E',
  'E',
  'E',
  'E',
  'E',
  'i',
  'i',
  'i',
  'i',
  'i',
  'I',
  'I',
  'I',
  'I',
  'I',
  'o',
  'o',
  'o',
  'o',
  'o',
  'o',
  'o',
  'o',
  'o',
  'o',
  'o',
  'o',
  'o',
  'o',
  'o',
  'o',
  'o',
  'O',
  'O',
  'O',
  'O',
  'O',
  'O',
  'O',
  'O',
  'O',
  'O',
  'O',
  'O',
  'O',
  'O',
  'O',
  'O',
  'O',
  'u',
  'u',
  'u',
  'u',
  'u',
  'u',
  'u',
  'u',
  'u',
  'u',
  'u',
  'U',
  'U',
  'U',
  'U',
  'U',
  'y',
  'y',
  'y',
  'y',
  'y',
  'Y',
  'Y',
  'Y',
  'Y',
  'Y',
  'd',
  'D',
  'U',
  'U',
  'U',
  'U',
  'U',
  'U'
];
const List<String> characterInName = [
  'à',
  'á',
  'ả',
  'ã',
  'ạ',
  'ă',
  'ằ',
  'ắ',
  'ẳ',
  'ẵ',
  'ặ',
  'â',
  'ầ',
  'ấ',
  'ẩ',
  'ẫ',
  'ậ',
  'À',
  'Á',
  'Ả',
  'Ã',
  'Ạ',
  'Ă',
  'Ằ',
  'Ắ',
  'Ẳ',
  'Ẵ',
  'Ặ',
  'Â',
  'Ầ',
  'Ấ',
  'Ẩ',
  'Ẫ',
  'Ậ',
  'è',
  'é',
  'ẻ',
  'ẽ',
  'ẹ',
  'ê',
  'ề',
  'ế',
  'ể',
  'ễ',
  'ệ',
  'È',
  'É',
  'Ẻ',
  'Ẽ',
  'Ẹ',
  'Ê',
  'Ề',
  'Ế',
  'Ể',
  'Ễ',
  'Ệ',
  'ì',
  'í',
  'ỉ',
  'ĩ',
  'ị',
  'Ì',
  'Í',
  'Ỉ',
  'Ĩ',
  'Ị',
  'ò',
  'ó',
  'ỏ',
  'õ',
  'ọ',
  'ô',
  'ồ',
  'ố',
  'ổ',
  'ỗ',
  'ộ',
  'ơ',
  'ờ',
  'ớ',
  'ở',
  'ỡ',
  'ợ',
  'Ò',
  'Ó',
  'Ỏ',
  'Õ',
  'Ọ',
  'Ô',
  'Ồ',
  'Ố',
  'Ổ',
  'Ỗ',
  'Ộ',
  'Ơ',
  'Ờ',
  'Ớ',
  'Ở',
  'Ỡ',
  'Ợ',
  'ù',
  'ú',
  'ủ',
  'ũ',
  'ụ',
  'ư',
  'ừ',
  'ứ',
  'ử',
  'ữ',
  'ự',
  'Ù',
  'Ú',
  'Ủ',
  'Ũ',
  'Ụ',
  'Ư',
  'Ừ',
  'Ứ',
  'Ử',
  'Ữ',
  'Ự',
  'ỳ',
  'ý',
  'ỷ',
  'ỹ',
  'ỵ',
  'Ỳ',
  'Ý',
  'Ỷ',
  'Ỹ',
  'Ỵ',
  'đ',
  'Đ',
  'a',
  'A',
  'b',
  'B',
  'c',
  'C',
  'd',
  'D',
  'e',
  'E',
  'f',
  'F',
  'g',
  'G',
  'h',
  'H',
  'i',
  'I',
  'j',
  'J',
  'k',
  'K',
  'l',
  'L',
  'm',
  'M',
  'n',
  'N',
  'o',
  'O',
  'p',
  'P',
  'q',
  'Q',
  'r',
  'R',
  's',
  'S',
  't',
  'T',
  'u',
  'U',
  'v',
  'V',
  'w',
  'W',
  'x',
  'X',
  'y',
  'Y',
  'z',
  'Z',
  ' '
];
const String specialCharactersString = "<>./!@#\$%^*'\"-_():|[]~+{}?\\\n";

extension StringUtils on String {
  /// Bỏ dấu tiếng Việt

  String fromUnicodeToEnglish() {
    String tempString = trim();
    if (tempString.isEmpty) {
      return emptyString;
    }
    for (int i = 0; i < withToneMarks.length; i++) {
      tempString = tempString.replaceAll(withToneMarks[i], withoutToneMarks[i]);
    }
    return tempString;
  }

  /*
   * Kiểm tra nickname hợp lệ
   * return: bool
   * author: TruongNH3
   */
  bool isValidUserName() {
    bool result = false;
    if (RegExp('^[0-9]+\$').hasMatch(this)) {
      result = false;
    } else if (RegExp('^[a-zA-Z0-9]+\$').hasMatch(this)) {
      result = true;
    }
    return result;
  }

  /*
  * Kiểm tra nội dung hợp lệ (có khoảng trắng)
  * return: bool
  * author: TruongNH3
  */

  bool isValidPaymentContent() {
    return RegExp('^[a-zA-Z0-9 ]+\$').hasMatch(this);
  }

  /*
  * Kiểm tra nội dung hợp lệ (Không khoảng trắng)
  * return: bool
  * author: TruongNH3
  */

  bool isValidPaymentContentWithoutSpace() {
    return RegExp('^[a-zA-Z0-9]+\$').hasMatch(this);
  }

  ///  Kiểm tra số Email hợp lệ
  ///  return: bool
  bool isValidEmail() {
    return RegExp(
            '''^(([^<>()[\\]\\\\.,;:\\s@"]+(\\.[^<>()[\\]\\\\.,;:\\s@"]+)*)|(".+"))@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))\$''')
        .hasMatch(this);
  }

  bool isValidPhoneNumber() {
    return RegExp(
            "^(?=.{10}\$)([0][1-9][0-9]+)|(?=.{10,11}\$)([+]?[28][48][1-9][0-9]+)\$")
        .hasMatch(this);
  }

  String? addCountryCodeToPhoneNumber() {
    String? validatedPhoneNumber;
    String phoneNumber = trim();
    const String countryCode = '84';
    const String contryCodeWithPlus = '+84';
    if (phoneNumber.isEmpty) {
      return null;
    }
    if (phoneNumber.startsWith(contryCodeWithPlus)) {
      validatedPhoneNumber = phoneNumber.substring(1);
    }

    //84906005535
    if (phoneNumber.startsWith(countryCode)) {
      validatedPhoneNumber = phoneNumber;
    } else if (phoneNumber.startsWith('0')) {
      validatedPhoneNumber = countryCode + phoneNumber.substring(1);
    }
    return validatedPhoneNumber;
  }

  ///Tạo mã hash Md5
  ///return: String
  String generateMd5() {
    return md5.convert(utf8.encode(this)).toString();
  }

  ///Tạo mã Hash SHA256
  ///return: String
  String generateSHA256() {
    return sha256.convert(utf8.encode(this)).toString();
  }

  /// Replace a character at [index] by [character]
  String replaceCharacterAtIndex(
      {required int index, required String character}) {
    String currentString = this;
    if (currentString.isEmpty) {
      return emptyString;
    } else if (index < 0 || index > currentString.length) {
      return currentString;
    } else {
      for (int i = 0; i <= index; i++) {
        if (i == index) {
          currentString = currentString.replaceAll(currentString[i], character);
        }
      }
      return currentString;
    }
  }

  /// Replace subsrting [from] to [to] after meet [count] time, with optional [separator]
  String replaceSubStringAtCount(String from, String to, int count,
      {Pattern separator = ' '}) {
    int numberOfTimeExist = 0;
    String currentString = trim();
    if (!currentString.contains(separator)) {
      return currentString;
    }
    List<String> eliminateSeparator = currentString.split(separator);

    for (var element in eliminateSeparator) {
      if (element.contains(from)) {
        numberOfTimeExist++;
        if (numberOfTimeExist == count) {
          eliminateSeparator[eliminateSeparator.indexOf(element)] =
              element.replaceAll(from, to);
          // print(eliminateSeparator[eliminateSeparator.indexOf(element)]);
          break;
        }
      }
    }
    return eliminateSeparator.join(separator as String);
  }

  bool isExist({required String pattern, required String separate}) {
    List<String> currentString = trim().split(separate);
    return currentString.any((element) {
      return element.contains(pattern);
    });
  }

  /// Return a number of [character] in String
  int countCharacterInString(String character) {
    int counter = 0;
    List<String> currentString = trim().split('');
    for (var element in currentString) {
      if (element == character) {
        counter++;
      }
    }
    return counter;
  }

  /// elliminate the redundant number of zeros '0' in exponent part of double
  String toFormatDoubleString() {
    String currentString = trim();
    final regex = RegExp(r'([.]*[0]*)(?!.*\d)');
    return currentString.replaceAll(regex, '');
  }

  bool isValidName() {
    List<String> currentString = trim().split('');
    return currentString.every((element) => characterInName.contains(element));
  }

  bool isNegativeNumber() {
    String currentString = trim();
    int indexOfDot = currentString.indexOf('.');
    if (indexOfDot != -1 &&
        currentString.substring(0, indexOfDot).contains('-')) {
      return true;
    }
    return false;
  }

  bool isViettelNumber() {
    return RegExp(
            r'(?=.{10}$)([0](9[678]|86|3[456789])[0-9]+)|(?=.{12}$)(([+][8][4])(9[678]|86|3[456789])[0-9]+)|(?=.{11}$)(([8][4])(9[678]|86|3[456789])[0-9]+)')
        .hasMatch(this);
  }

  DateTime toDateTime({String pattern = '/'}) {
    if (isEmpty) {
      return DateTime.now();
    }
    List<String> currentString = trim().split(pattern).fold([], (x, y) {
      x.insert(0, y);
      return x;
    });
    if (currentString[1].length == 1) {
      currentString[1] =
          currentString[1].replaceAll(currentString[1], '0${currentString[1]}');
    }
    return DateTime.parse(currentString.join());
  }

  /// Format the DateTime String from [inputSeparator] to [outputSeparator]
  ///
  /// Parameter [chineseFormat] allow us to chang from 'ddMMyyyy' to 'yyyyMMdd',
  /// Parameter [inputSeparator] must be provided by the current String
  ///
  /// - for an example: 28/03/2000, [inputSeparator] will be '/'
  String toFormatDateTimeString(String inputSeparator,
      {bool chinesessFormat = false, String outputSeparator = '/'}) {
    if (RegExp(r'(?=.{8}$)[0-9]+').hasMatch(trim()) || isEmpty) {
      return this;
    }

    List<String> returnValue = [];
    List<String> currentString = trim().split(inputSeparator);
    // If user input month only 1 digit: 28/3/2001 -> change to 28/03/2001
    if (currentString[1].length == 1) {
      currentString[1] =
          currentString[1].replaceAll(currentString[1], '0${currentString[1]}');
    }
    // Change separator and format:
    //From chinese format to world format
    if (currentString[0].length == 4 && chinesessFormat == false) {
      returnValue = currentString.fold([], (previousValue, element) {
        previousValue.insert(0, element);
        return previousValue;
      });
      return returnValue.join(outputSeparator);
    }
    //Keep Chinese format
    else if (currentString[0].length == 4 && chinesessFormat == true) {
      return currentString.join(outputSeparator);
    }
    //From World format to Chinese format
    else if (chinesessFormat == true) {
      returnValue = currentString.fold([], (previousValue, element) {
        previousValue.insert(0, element);
        return previousValue;
      });
      return returnValue.join(outputSeparator);
    }
    //Keep World format
    else {
      return currentString.join(outputSeparator);
    }
  }

  ///Change from [oldString] to [newString]
  String toNewString(String from, String to) {
    return replaceAll(from, to);
  }

  /// Allow only [numberOfDigit] digits in decimal part, without rouding
  String toLimitDecimalPart({required int numberOfDigit}) {
    if (numberOfDigit < 0) {
      throw Exception('Number of digit must be larger than zero');
    }
    String currentString = trim();
    if (currentString.isEmpty) {
      return emptyString;
    }
    int indexOfDot = trim().indexOf('.');
    if (indexOfDot == -1) {
      return this;
    } else if (substring(indexOfDot).length - 1 < numberOfDigit) {
      int diffrence = numberOfDigit - (substring(indexOfDot).length - 1);
      for (int i = 0; i < diffrence; i++) {
        currentString = currentString + '0';
      }
      return currentString;
    } else if (substring(indexOfDot).length - 1 == numberOfDigit) {
      return substring(0, indexOfDot + numberOfDigit);
    } else {
      return substring(0, indexOfDot + numberOfDigit + 1);
    }
  }

  /// Allow only [numberOfDigit] digits in decimal part, with rouding
  String toRoundUpDecimalPart(int numberOfDigit) {
    String currentString = trim();
    int indexOfDot = trim().indexOf('.');
    if (indexOfDot == -1) {
      return this;
    } else if (substring(indexOfDot).length - 1 < numberOfDigit) {
      int diffrence = numberOfDigit - (substring(indexOfDot).length - 1);
      for (int i = 0; i < diffrence; i++) {
        currentString = currentString + '0';
      }
      return currentString;
    } else if (substring(indexOfDot).length - 1 == numberOfDigit) {
      return substring(0, indexOfDot + numberOfDigit);
    } else {
      String fromDotToFinalDigit = currentString.substring(
          indexOfDot + 1, indexOfDot + numberOfDigit + 1);
      int finalElementAfterRounded =
          int.parse(fromDotToFinalDigit[fromDotToFinalDigit.length - 1]);
      int firstEliminatedElement =
          int.parse(currentString[indexOfDot + numberOfDigit + 1]);
      if (firstEliminatedElement >= 5) {
        currentString = currentString.substring(0, indexOfDot + numberOfDigit) +
            ((finalElementAfterRounded + 1).toString());
      } else {
        currentString =
            currentString.substring(0, indexOfDot + numberOfDigit + 1);
      }
    }
    return currentString;
  }

  ///Rounding up or down, the parameter [isRoundUp] is automatically set to true.
  ///If true, the number is rounded up otherwise it will be rounded down.
  ///
  ///Return: int
  num round(bool isRoundUp) {
    if (contains('.')) {
      double number = double.parse(this);
      return !isRoundUp ? number.floor() : number.ceil();
    } else {
      int number = int.parse(this);
      return !isRoundUp ? number.floor() : number.ceil();
    }
  }

  /// Convert form String to Number type (int/double)
  /// return: double/int
  num toNum() {
    return contains('.') ? double.parse(this) : int.parse(this);
  }

  /// Format the money, [pattern] will be used to decide which
  /// kind of separator will be use
  ///
  /// Example 1000000 -> 1,000,000
  /// return: String
  String parseMoney([String pattern = ',']) {
    String result = '';
    String currentString = trim();
    if (currentString.isEmpty) {
      result = '';
    } else if (!currentString.contains('.')) {
      for (int i = currentString.length - 1; i >= 0; i--) {
        int last = currentString.length - 1 - i;
        if ((last > 0) &&
            (last % 3 == 0) &&
            (currentString[i] != '+') &&
            (currentString[i] != '-')) {
          result = pattern + result;
        }
        result = currentString[i] + result;
      }
    } else {
      int indexOfDot = currentString.indexOf('.');
      String fromStartToDot =
          currentString.substring(0, indexOfDot).replaceAll(',', '');
      String fromDotToEnd =
          currentString.substring(indexOfDot, currentString.length);
      for (int i = fromStartToDot.length - 1; i >= 0; i--) {
        int last = fromStartToDot.length - 1 - i;
        if ((last > 0) &&
            (last % 3 == 0) &&
            (fromStartToDot[i] != '+') &&
            (fromStartToDot[i] != '-')) {
          result = pattern + result;
        }
        result = fromStartToDot[i] + result;
      }
      result = result + fromDotToEnd;
    }
    return result;
  }

  /// Decode URL: change the '%20' to ' '

  /// return: String
  String decodeUrl() {
    return replaceAll('%20', " ");
  }

  /// Decode URL: change the ' ' to '%20'
  /// return: String
  String encodeUrl() {
    return replaceAll(" ", "%20");
  }

  /// Eliminate +84/84/0 out of the phone number
  /// return: String

  String truncatePhoneNumber() {
    if (startsWith('0')) {
      return replaceFirst(r'0+(?!$)', '');
    } else if (startsWith('84')) {
      return substring(2);
    } else if (startsWith('+84')) {
      return substring(3);
    }
    return this;
  }

  /// Get the the file name from url
  ///
  /// https://www.192.168.1.171/data/file.zip -> "file"
  /// return String
  String fromURLToFileName() {
    String filename;
    if (isEmpty) {
      return this;
    } else {
      filename = trim().substring(lastIndexOf('/') + 1, length);
      return filename.substring(0, filename.indexOf('.'));
    }
  }

  /// Escape SQL special character
  String escapeSqlString() {
    String currentString = trim();
    currentString = currentString.replaceAll("^", "^^"); // escape char
    currentString = currentString.replaceAll("_", "^_"); // search 1 character
    currentString = currentString.replaceAll("%", "^%"); // search all
    return currentString;
  }
}

extension DateTimeExtension on DateTime {
  /// Chuyển đổi DateTime -> String
  /// return: String
  /// fixed format: dd/MM/yyyy
  String fromDateTimeToString([String pattern = 'dd/MM/yyyy']) {
    return DateFormat(pattern).format(this);
  }
}
