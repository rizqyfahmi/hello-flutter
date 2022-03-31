import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter/person.dart';

void main() {
  Person p = Person();

  group("Check person class", (){
    test("Initialize person object", () {
      print("test 1");
      expect(p.name, equals("No name"));
      expect(p.age, equals(0));
    });

    test("Age must be positive", () {
      p.age = -5;
      expect(p.age, isPositive);
    });

    test("Lucky number must have 3 positive numbers", () {
      expect(p.luckyNumbers, allOf([
        hasLength(3),
        isNot(anyElement(isNegative))
      ]));
    });

    // it used to executed block of code before every test we run
    setUp(() {
      print("set up");
    });

    // it used to executed block of code after every test we run
    tearDown(() {
      print("tear down");
    });
  });
}