
import 'package:bloc/bloc.dart';
import 'package:hello_flutter/bloc/counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Add>((event, emit) {
      emit(state + event.amount);
    });
    on<Substract>((event, emit) {
      emit(state - event.amount);
    });
  }
}