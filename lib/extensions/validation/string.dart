import 'dart:convert';

import 'package:intl/intl.dart';

extension StringValidation on String {

  ///see [RegExp]
  bool matches(String pattern, {bool caseSensitive = true,
    bool multiLine = false,
    bool unicode = false,
    bool dotAll = false
  }) {
    RegExp regExp = RegExp(pattern,
      caseSensitive: caseSensitive,
      multiLine: multiLine,
      unicode: unicode,
      dotAll: dotAll
    );
    return regExp.hasMatch(this);
  }

  bool get isInt {
    return int.tryParse(this) != null;
  }

  ///delimiter ',' will not be recognized, only accept '.'
  bool get isDouble {
    return double.tryParse(this) != null;
  }

  bool get isNumeric {
    return num.tryParse(this) != null;
  }

  bool get isUpperCase {
    return matches(r'^[^a-z]+$');
  }

  bool get isLowerCase {
    return matches(r'^[^A-Z]+$');
  }

  ///Only work with strings that are formatted according to [DateTime.parse].<br>
  ///Please use [isFormattedDateTime] for other formats like 25/12/2000.
  bool get isDateTime {
    return DateTime.tryParse(this) != null;
  }

  bool isDateTimeByFormat(DateFormat format) {
    try {
      format.parseStrict(this);
      return true;
    } catch (_) {
      return false;
    }
  }

  bool isAlphabet({bool acceptWhiteSpace = true,
    bool unicode = false,
  }) {
    return _validateAlphabetNumeric(
        acceptWhiteSpace: acceptWhiteSpace,
        validateNumeric: false,
        unicode: unicode
    );
  }

  ///used internally to prevent code duplication
  bool _validateAlphabetNumeric({
    bool acceptWhiteSpace = true,
    bool validateNumeric = false,
    bool unicode = false,
  }) {
    String alphabet = unicode? "\\p{L}": "A-Za-z";
    String numeric = validateNumeric? "0-9": "";
    String whiteSpace = acceptWhiteSpace? "\\s": "";

    return matches("^[$alphabet$numeric$whiteSpace}]+\$", unicode: unicode);
  }

  bool isAlphabetNumeric({bool acceptWhiteSpace = true,
    bool unicode = false,
  }) {
    return _validateAlphabetNumeric(
      acceptWhiteSpace: acceptWhiteSpace,
      validateNumeric: true,
      unicode: unicode
    );
  }


  bool isURL({List<String> protocols = const ['http', 'https', 'ftp'],
    bool requireProtocol = true,
  }) {
    Uri? uri = Uri.tryParse(this);

    if (uri == null) return false;

    //check protocol
    if (requireProtocol) {
      if (!_validateProtocol(protocols, uri)) {
        return false;
      }
    }

    if (uri.hasAbsolutePath) {
      return true;
    } else {
      return false;
    }
  }

  bool _validateProtocol(List<String> protocols, Uri uri) {
    if (!uri.hasScheme) {
      return false;
    } else {
      if (protocols.any((protocol) => protocol == uri.scheme)) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool get isCamelCase {
    return matches(r'^([A-Z][a-z]*\s?)+$');
  }

  bool get isHexColor {
    return matches(r'^#(?:[0-9a-fA-F]{3}){1,2}$');
  }

  bool get isARGBHexColor {
    return matches(r'^#(?:[0-9a-fA-F]{3,4}){1,2}$');
  }

  bool get isJson {
    try {
      jsonDecode(this);
      return true;
    } catch (_) {
      return false;
    }
  }

  //regex src: https://stackoverflow.com/a/36760050
  bool get isIPv4 {
    return matches(r'^((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])(\.(?!$)|$)){4}$');
  }

  //regex src:
  bool get isIPv6 {
    try {
      return Uri.parseIPv6Address(this).isNotEmpty;
    } catch (_) {
      return false;
    }
    // return matches(r'(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))');
  }

  bool get isIP {
    return isIPv4 || isIPv6;
  }

  bool get isUUID {
    return matches(r'^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$');
  }

  ///<h3>Default number part accepted format: </h3>
  /// 100.000.000<br>
  /// 100,000,000<br>
  /// 100,000,000.00<br>
  ///<h3>For the ending part: </h3>
  /// 100.000.000VND<br>
  /// 100.000.000 VND<br>
  /// 100.000.000vnd<br>
  /// 100.000.000 vnd<br>
  ///<h3>minus or plus sign at the start will also be accepted</h3>
  ///You can change the ending by using [ending] or remove delimiter by using [hasDelimiter]
  bool isVND({
    List<String> delimiters = const [".", ","],
    List<String> ending = const ["VND", "vnd"],
  }) {
    String delimiterPattern = delimiters.isNotEmpty? "[${_generateDelimiterRegex(delimiters)}]?": "";
    String endingPattern = ending.isNotEmpty? "(${ending.join("|")})": "";
    String pattern = "^\\-?\\+?(\\d+$delimiterPattern)*\\s?$endingPattern\\b\$";

    return matches(pattern);
  }
  
  String _generateDelimiterRegex(List<String> delimiters) {
    StringBuffer result = StringBuffer();
    delimiters.forEach((delimiter) => result.write("\\$delimiter"));
    return result.toString();
  }

  // bool get isUSD {
  //
  // }
  //
  // bool get isVNPhoneNumber {
  //
  // }
}