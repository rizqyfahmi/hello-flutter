import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/cubit/counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(InitialState());

  void increament() {
    if (state is InitialState) {
      return emit(LoadedState(1));
    }

    final currentState = state as LoadedState;
    emit(LoadedState(currentState.amount + 1));
  }

  void decreament() {
    if (state is InitialState) {
      return emit(LoadedState(-1));
    }

    final currentState = state as LoadedState;
    emit(LoadedState(currentState.amount - 1));
  }
}