import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:hello_flutter/model/counter.dart';

class CounterReactiveController extends GetxController {
  Rx<Counter> counter = Counter().obs;

  void increament() {
    counter.update((val) {
      val?.amount += 1;
    });
  }

  void decreament() {
    counter.update((val) {
      val?.amount -= 1;
    });
  }
}