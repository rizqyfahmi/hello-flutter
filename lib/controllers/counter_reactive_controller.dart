import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class CounterReactiveController extends GetxController {
  Rx<int> amount = Rx<int>(0);

  void increament() {
    amount.value += 1;
  }

  void decreament() {
    amount.value -= 1;
  }
}