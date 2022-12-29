import 'dart:collection';

import 'package:flutter_core/extensions/validation/object.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_validation_test.dart';

class ObjectValidationTest extends BaseValidationTest {
  void testIsIn() {
    //map and list test cases
    expect("asd".isIn(["asd", 1, 2.2]), true);
    expect(1.isIn(["asd", 1, 2.2]), true);
    expect("asd".isIn({"asd": "asd", "123": 1, "122": 2.2}), true);
    expect(1.isIn({"asd": "asd", "123": 1, "122": 2.2}), true);

    expect("asd".isIn({"asd": "asdasd", "123": 1, "122": 2.2}), false);
    expect(2.isIn({"asd": "asd", "123": 1, "122": 2.2}), false);

    //tree

    SplayTreeSet<num> treeSet = SplayTreeSet();
    treeSet.add(1);
    treeSet.add(2);
    treeSet.add(2.1);

    expect(1.isIn(treeSet), true);
    expect(2.1.isIn(treeSet), true);

    expect(12.isIn(treeSet), false);
    expect("string".isIn(treeSet), false);

    LinkedHashSet<double> hashSet = LinkedHashSet();
    hashSet..add(1)..add(2)..add(2.1);

    expect(1.isIn(hashSet), true);
    expect(2.1.isIn(hashSet), true);

    expect(12.isIn(hashSet), false);
    expect("string".isIn(hashSet), false);

    SplayTreeMap<dynamic, dynamic> treeMap = SplayTreeMap();
    treeMap.putIfAbsent("123", () => 1);
    treeMap.putIfAbsent("122", () => "string");
    treeMap.putIfAbsent("121", () => 2.1);

    expect(1.isIn(treeMap), true);
    expect("string".isIn(treeMap), true);

    expect(12.isIn(treeMap), false);
    expect("string2".isIn(treeMap), false);
  }
  @override
  String get name => "Object";
  @override
  void start() {
    testIsIn();
  }
}