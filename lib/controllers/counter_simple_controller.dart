import 'package:get/get_state_manager/get_state_manager.dart';

class CounterSimpleController extends GetxController {
  int amount = 0;

  void increament() {
    amount += 1;
    update(); // Add this line to notify the observer that the state is changed
  }

  void decreament() {
    amount -= 1;
    update(); // Add this line to notify the observer that the state is changed
  }
}