import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hello_flutter/model/counter.dart';

class CounterSimpleController extends GetxController {
  Counter counter = Counter();

  void increament() {
    counter.amount += 1;
    update(["hello"]); // Add this line to notify the observer that the state is changed
  }

  void decreament() {
    counter.amount -= 1;
    update(["hello"]); // Add this line to notify the observer that the state is changed
  }
}