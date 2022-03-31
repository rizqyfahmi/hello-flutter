import 'package:flutter/material.dart';

@immutable
abstract class CounterEvent {
  final int amount;

  const CounterEvent(this.amount);
}

class Add extends CounterEvent {
  const Add(int amount):super(amount);
}

class Substract extends CounterEvent {
  const Substract(int amount):super(amount);
}
