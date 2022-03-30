import 'package:mobx/mobx.dart';
part 'counter.g.dart';

class Counter = CounterBase with _$Counter;

abstract class CounterBase with Store {
  @observable
  int nominal = 0;

  CounterBase();

  @action
  void increament() {
    nominal++;
  }

  @action
  void decreament() {
    nominal--;
  }

}