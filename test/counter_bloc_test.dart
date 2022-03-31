import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter/bloc/counter_bloc.dart';
import 'package:hello_flutter/bloc/counter_event.dart';

void main() {
  group("Testing Counter Bloc", () {
    test("Init Counter Bloc", () {
      final bloc = CounterBloc();
      expect(bloc.state, equals(0));
    });

    blocTest<CounterBloc, int>(
      "Add Event", 
      build: () => CounterBloc(), 
      act: (bloc) => bloc.add(const Add(2)), 
      expect: () => [2]
    );

    blocTest<CounterBloc, int>(
      "Add More Event",
      build: () => CounterBloc(),
      act: (bloc) => {
        bloc.add(const Add(2)),
        bloc.add(const Add(2))
      },
      expect: () => [2, 4]
    );

    blocTest<CounterBloc, int>(
      "Substract Event",
      build: () => CounterBloc(),
      act: (bloc) => bloc.add(const Substract(2)),
      expect: () => [-2]
    );

    blocTest<CounterBloc, int>(
      "Substract More Event",
      build: () => CounterBloc(),
      act: (bloc) => {
        bloc.add(const Substract(2)),
        bloc.add(const Substract(2))
      },
      expect: () => [-2, -4]
    );

    blocTest<CounterBloc, int>(
      "Add and Substract Event",
      build: () => CounterBloc(),
      act: (bloc) => {
        bloc.add(const Add(2)),
        bloc.add(const Substract(2))
      },
      expect: () => [2, 0]
    );
  });
}