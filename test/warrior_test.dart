import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter/warrior.dart';
import 'package:mockito/mockito.dart';

class MockWarrior extends Mock implements Warrior {
  // Used to null-safety
  // Manually override a method with a non-nullable return type.
  @override
  String get name => super.noSuchMethod(Invocation.getter(#name), returnValue: "no name");

  // Used to null-safety
  // Manually override a method with a non-nullable return type.
  @override
  Future<bool> trainning() {
    return super.noSuchMethod(Invocation.method(#trainning, []), returnValue: Future.value(true) as Future<bool>);
  }
}

void main() {
  MockWarrior warrior = MockWarrior();

  test("Verify demo", (){
    warrior.rest();
    warrior.rest();
    verify(warrior.rest()).called(2);
  });

  test("VerifyIOrder demo", () {
    when(warrior.trainning()).thenAnswer((_) async => true);
    warrior.rest();
    warrior.trainning();
    verifyInOrder([
      warrior.rest(),
      warrior.trainning()
    ]);
  });

  test("thenThrow demo", () {
    when(warrior.rest()).thenThrow(Exception("Boo"));
    expect(() => warrior.rest(), throwsException);
  });

  test("thenReturn demo", () {
    when(warrior.name).thenReturn("no name");
    expect(warrior.name, "no name");
  });
}