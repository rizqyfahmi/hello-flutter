import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CounterState extends Equatable {

}

class InitialState extends CounterState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends CounterState {
  final int amount;

  LoadedState(this.amount);

  @override
  List<Object?> get props => [amount];
}