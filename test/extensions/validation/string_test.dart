import 'package:flutter_core/extensions/extensions.dart';
import 'package:flutter_core/extensions/validation/string.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'base_validation_test.dart';

class StringValidationTest extends BaseValidationTest{

  //test cases https://viblo.asia/p/viet-testcase-check-validate-email-07LKXpDJKV4
  void testIsEmail() {
    //positive cases
    //case IP address as domain will not pass
    expect("email@domain.com".isValidEmail(), true);
    expect("firstname.lastname@domain.com".isValidEmail(), true);
    expect("email@subdomain.domain.com".isValidEmail(), true);
    expect("Firstname+lastname@domain.com".isValidEmail(), true);
    expect("\"email\"@domain.com".isValidEmail(), true);
    expect("1234567890@domain.com".isValidEmail(), true);
    expect("email@domain-one.com".isValidEmail(), true);
    expect("email@domain.name".isValidEmail(), true);
    expect("email@domain.co.jp".isValidEmail(), true);
    expect("Firstname-lastname@domain.com".isValidEmail(), true);

    //negative cases
    expect("plainaddress".isValidEmail(), false);
    expect("#@%^%#@#@#.com".isValidEmail(), false);
    expect("@domain.com".isValidEmail(), false);
    expect("JoeSmith<email@domain.com>".isValidEmail(), false);
    expect("email.domain.com".isValidEmail(), false);
    expect("email@domain@domain.com".isValidEmail(), false);
    expect(".email@domain.com".isValidEmail(), false);
    expect("email.@domain.com".isValidEmail(), false);
    expect("email..email@domain.com".isValidEmail(), false);
    expect("& #12354;& #12356; & #12353; & #12360; & #12362; @ domain.com".isValidEmail(), false);
    expect("email@domain.com (Joe Smith)".isValidEmail(), false);
    expect("email@domain".isValidEmail(), false);
    expect("email@111.222.333.44444".isValidEmail(), false);
    expect("@domain..com".isValidEmail(), false);
  }

  void testIsInt() {
    expect("12304192".isInt, true);
    expect("1123.273".isInt, false);
    expect("1123,273".isInt, false);
    expect("1123.273.1231".isInt, false);
    expect("1a".isInt, false);
  }

  void testIsDouble() {
    expect("12304192".isDouble, true);
    expect("1032.12391009993912".isDouble, true);
    expect("1123,273".isDouble, false);
    expect("1123.273.1231".isDouble, false);
    expect("1a".isDouble, false);
  }

  void testIsNumeric() {
    expect('3.14 \xA0'.isNumeric, true);
    expect('0.'.isNumeric, true);
    expect('.0'.isNumeric, true);
    expect('-1.e3'.isNumeric, true);
    expect('NaN'.isNumeric, true);
    expect('-NaN'.isNumeric, true);
    expect('+.12e-9'.isNumeric, true);
    expect('0xab'.isNumeric, true);

    expect('123x'.isNumeric, false);
    expect('1,232,231'.isNumeric, false);
    expect('INFINITY'.isNumeric, false);

  }

  void testIsUpperCase() {
    expect('VIETTEL SOLUTIONS'.isUpperCase, true);
    expect('ViEtTel Solutions'.isUpperCase, false);

    expect('VIETTEL SOLUTIONS @#@#@^^@!'.isUpperCase, true);
  }

  void testIsLowerCase() {
    expect('viettel solutions'.isLowerCase, true);
    expect('ViEtTel Solutions'.isLowerCase, false);

    expect('viettel solutions !12312'.isLowerCase, true);
  }

  void testIsDateTime() {
    expect('2022-12-02'.isDateTime, true);
    expect('2022-12-02 22:12:22'.isDateTime, true);
    expect('1669707386'.isDateTime, true);
    expect('2022-11-29T07:49:29Z'.isDateTime, true);

    expect('22/12/2022'.isDateTimeByFormat(DateFormat('dd/mm/yyyy')), true);
  }

  void testIsAlphabet() {
    expect("alphabet string".isAlphabet(), true);
    expect("alphabet 123 ".isAlphabet(), false);
    expect("alphabet #!^^".isAlphabet(), false);

    expect("alphabet string".isAlphabet(acceptWhiteSpace: false), false);
    expect("alphabet 123 ".isAlphabet(acceptWhiteSpace: false), false);
    expect("alphabet #!^^".isAlphabet(acceptWhiteSpace: false), false);
  }

  void testIsAlphabetUnicode() {
    expect("bảng chữ cái".isAlphabet(unicode: true), true);
    expect("bảng chữ cái 123 ".isAlphabet(unicode: true), false);
    expect("bảng chữ cái #!^^".isAlphabet(unicode: true), false);

    expect("bảng chữ cái".isAlphabet(unicode: true, acceptWhiteSpace: false), false);
    expect("bảng chữ cái 123 ".isAlphabet(unicode: true, acceptWhiteSpace: false), false);
    expect("bảng chữ cái #!^^".isAlphabet(unicode: true, acceptWhiteSpace: false), false);
  }

  void testAlphabetNumeric() {
    expect("alphabet string".isAlphabetNumeric(), true);
    expect("alphabet 123 ".isAlphabetNumeric(), true);
    expect("alphabet #!^^".isAlphabetNumeric(), false);

    expect("alphabet string".isAlphabetNumeric(acceptWhiteSpace: false), false);
    expect("alphabet 123 ".isAlphabetNumeric(acceptWhiteSpace: false), false);
    expect("alphabet #!^^".isAlphabetNumeric(acceptWhiteSpace: false), false);
  }

  void testAlphabetNumericUnicode() {
    expect("bảng chữ cái".isAlphabetNumeric(unicode: true), true);
    expect("bảng chữ cái 123 ".isAlphabetNumeric(unicode: true), true);
    expect("bảng chữ cái #!^^".isAlphabetNumeric(unicode: true), false);

    expect("bảng chữ cái".isAlphabetNumeric(unicode: true, acceptWhiteSpace: false), false);
    expect("bảng chữ cái 123 ".isAlphabetNumeric(unicode: true, acceptWhiteSpace: false), false);
    expect("bảng chữ cái #!^^".isAlphabetNumeric(unicode: true, acceptWhiteSpace: false), false);
  }

  void testIsUrl() {
    expect("https://stackoverflow.com/questions/52975739/dart-flutter-validating-a-string-for-url".isURL(), true);
    expect("localhost..123".isURL(requireProtocol: false), false);
    expect("http://localhost:5114/".isURL(requireProtocol: false), true);
    expect("asd".isURL(requireProtocol: false), false);
    expect("https:".isURL(), false);
    expect("https://".isURL(), false);
    expect("https://a".isURL(), false);
    expect("https://a/".isURL(), true);
  }

  void testIsCamelCase() {
    expect("Camel Case C".isCamelCase, true);
    expect("Camel Case C1".isCamelCase, false);
    expect("Camel case Cs".isCamelCase, false);
    expect("Camel Case C@!".isCamelCase, false);
  }

  void testIsHexColor() {
    expect("#f5edbd".isHexColor, true);
    expect("#F5EdbD".isHexColor, true);
    expect("#F23".isHexColor, true);

    expect("#F5EdbDD".isHexColor, false);
    expect("#F2309".isHexColor, false);
    expect("F2309".isHexColor, false);
  }

  void testIsARGBHexColor() {
    expect("#f5edbd".isARGBHexColor, true);
    expect("#f5edbd".isARGBHexColor, true);
    expect("#AAF5EdbD".isARGBHexColor, true);
    expect("#aaF5EdbD".isARGBHexColor, true);
    expect("#F23".isARGBHexColor, true);
    expect("#2F23".isARGBHexColor, true);

    expect("#F235EdbDD".isARGBHexColor, false);
    expect("#F2309".isARGBHexColor, false);
    expect("F2309".isARGBHexColor, false);
  }

  void testIsJson() {
    String jsonSample1 = r'''{"fruit":"Apple","size":"Large","color":"Red"}''';
    String jsonSample2 = r'''{"quiz":{"sport":{"q1":{"question":"Which one is correct team name in NBA?","options":["New York Bulls","Los Angeles Kings","Golden State Warriros","Huston Rocket"],"answer":"Huston Rocket"}},"maths":{"q1":{"question":"5 + 7 = ?","options":["10","11","12","13"],"answer":"12"},"q2":{"question":"12 - 8 = ?","options":["1","2","3","4"],"answer":"4"}}}}''';

    String errorJsonSample1 = r'''{fruit":"Apple","size":"Large","color":"Red"}''';
    String errorJsonSample2 = r'''{"quiz":{"sport":{"q1":{"question":"Which one is correct team name in NBA?","options":["New York Bulls","Los Angeles Kings","Golden State Warriros","Huston Rocket"],answer:"Huston Rocket"}},"maths":{"q1":{"question":"5 + 7 = ?","options":["10","11","12","13"],"answer":"12"},"q2":{"question":"12 - 8 = ?","options":["1","2","3","4"],"answer":"4"}}}}''';
    String errorJsonSample3 = r'''fruit":"Apple","size":"Large","color":"Red"}''';

    expect(jsonSample1.isJson, true);
    expect(jsonSample2.isJson, true);

    expect(errorJsonSample1.isJson, false);
    expect(errorJsonSample2.isJson, false);
    expect(errorJsonSample3.isJson, false);
  }

  void testIsIPv4() {
    expect("192.2.10.10".isIPv4, true);
    expect("192.254.254.254".isIPv4, true);

    expect("592.2.10.10".isIPv4, false);
    expect("192.2.10.10.".isIPv4, false);
    expect("192.2.10.10.12".isIPv4, false);
  }

  void testIsIPv6() {
    expect("2345:0425:2CA1:0000:0000:0567:5673:23b5".isIPv6, true);

    expect("592.2.10.10".isIPv6, false);
  }

  //uuid generated using: https://www.uuidgenerator.net/version1
  void testIsUUID() {
    //v1
    expect("22f6a390-6fcc-11ed-a1eb-0242ac120002".isUUID, true);
    expect("22F6A390-6fcC-11ED-A1eb-0242ac120002".isUUID, true);
    //v4
    expect("0250b04c-1569-4b3f-88b6-1aa323a08bd4".isUUID, true);
    expect("0250B04c-1569-4B3F-88b6-1AA323a08BD4".isUUID, true);

    expect("0250B04c2-1569-4b3F-88b6-1aa323a08bd4".isUUID, false);
    expect("0250b04c-1569-4B3f-88b61aa323a08bd4".isUUID, false);
  }

  void testIsVND() {
    expect("200.000VND".isVND(), true);
    expect("123.202.200.000 vnd".isVND(), true);
    expect("200,000.00 VND".isVND(), true);
    expect("-123,202,200.223 vnd".isVND(), true);

    expect("-a123,202,200.223 vnd".isVND(), false);
    expect("-123,202,200.223vn".isVND(), false);

    expect("1000/200vnd".isVND(delimiters: ["/"]), true);
  }

  // void testIsUSD() {
  //
  // }

  void testIsPhoneNumber() {
    expect("0902093822".isValidPhoneNumber(), true);
    expect("0345406977".isValidPhoneNumber(), true);
    expect("03454069772".isValidPhoneNumber(), false);
  }
  @override
  String get name => "String";
  @override
  void start() {
    testIsEmail();
    testIsInt();
    testIsNumeric();
    testIsUpperCase();
    testIsLowerCase();
    testIsDateTime();
    testIsAlphabet();
    testIsAlphabetUnicode();
    testAlphabetNumeric();
    testAlphabetNumericUnicode();
    testIsUrl();
    testIsCamelCase();
    testIsHexColor();
    testIsARGBHexColor();
    testIsJson();
    testIsIPv4();
    testIsIPv6();
    testIsUUID();
    testIsVND();
    // testIsUSD();
    testIsPhoneNumber();
  }
}