import 'package:get/get_state_manager/get_state_manager.dart';

class CounterStateMixinController extends GetxController with StateMixin<Map<String, dynamic>> {
  
  // Use StateMixin when you want to make a controller that include lifecycle
  @override
  void onInit() {
    change({"amount": 0, "title": "hello world"}, status: RxStatus.success());
    super.onInit();
  }

  void onIncreament() {
    change({"amount": (state?["amount"] + 1) ?? 0, "title": state?["title"] ?? ""}, status: RxStatus.success());
  }

  void onDecreament() {
    change({"amount": (state?["amount"] - 1) ?? 0, "title": state?["title"] ?? ""}, status: RxStatus.success());
  }

  void onUppercase() {
    change({"amount": state?["amount"] ?? 0, "title": (state?["title"] ?? "").toString().toUpperCase()}, status: RxStatus.success());
  }

  void onLowercase() {
    change({"amount": state?["amount"] ?? 0, "title": (state?["title"] ?? "").toString().toLowerCase()}, status: RxStatus.success());
  }
}