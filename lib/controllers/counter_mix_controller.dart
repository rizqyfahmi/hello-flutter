import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class CounterMixController extends GetxController {
  // Reactive
  Rx<int> amount = Rx<int>(0);
  // Simple
  String title = "hello world";

  /* ---------------- Start | Reactive ---------------- */
  void increament() {
    amount.value += 1;
  }

  void decreament() {
    amount.value -= 1;
  }
  /* ---------------- End | Reactive ---------------- */

  /* ---------------- Start | Simple ---------------- */
  void convertToUppercase() {
    title = title.toUpperCase();
    update(); // Add this line to notify the observer that the state is changed
  }

  void convertToLowercase() {
    title = title.toLowerCase();
    update(); // Add this line to notify the observer that the state is changed
  }
  /* ---------------- End | Simple ---------------- */
}
