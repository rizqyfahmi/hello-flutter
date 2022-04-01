import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter/cubit/counter_cubit.dart';
import 'package:hello_flutter/cubit/counter_state.dart';

void main() {
  group("Cubit Test", () {
    test("Init Cubit", () {
      final cubit = CounterCubit();
      expect(cubit.state, equals(InitialState()));
    });

    blocTest(
      "Increment", 
      build: () => CounterCubit(),
      act: (CounterCubit bloc) => bloc.increament(),
      expect: () => [LoadedState(1)]
    );

    blocTest(
      "Decrement", 
      build: () => CounterCubit(),
      act: (CounterCubit bloc) => bloc.decreament(),
      expect: () => [LoadedState(-1)]
    );

    blocTest("Decrement",
        build: () => CounterCubit(),
        act: (CounterCubit bloc) => {
          bloc.increament(),
          bloc.decreament()
        },
        expect: () => [LoadedState(1), LoadedState(0)]);
  });
}