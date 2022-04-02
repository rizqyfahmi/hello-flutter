import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/controllers/counter_state_mixin_controller.dart';

class FourthPage extends StatelessWidget {
  final ctrl = Get.put(CounterStateMixinController());

  FourthPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ctrl.obx(
              (state) {
                developer.log(state.toString());
                return Column(
                  children: [
                    Text(
                      "${state?["title"] ?? "No Title"}",
                      style: const TextStyle(fontSize: 30)
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${state?["amount"] ?? "No Title"}",
                      style: const TextStyle(fontSize: 50)
                    )
                  ],
                );
              }
            ),
            const SizedBox(width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag:
                      "btn-increament", // Add this line to avoid error "There are multiple heroes that share the same tag within a subtree"
                  child: const Icon(Icons.arrow_upward),
                  onPressed: () {
                    ctrl.onIncreament();
                  }
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  heroTag:
                      "btn-decreament", // Add this line to avoid error "There are multiple heroes that share the same tag within a subtree"
                  child: const Icon(Icons.arrow_downward),
                  onPressed: () {
                    ctrl.onDecreament();
                  }
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: "btn-uppercase", // Add this line to avoid error "There are multiple heroes that share the same tag within a subtree"
                  child: const Icon(Icons.sunny),
                  onPressed: () {
                    ctrl.onUppercase();
                  }
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: "btn-lowercase", // Add this line to avoid error "There are multiple heroes that share the same tag within a subtree"
                  child: const Icon(Icons.bedtime),
                  onPressed: () {
                    ctrl.onLowercase();
                  }
                )
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed("/main");
              } , 
              child: const Text("Back to Main Page")
            ),
          ],
        ),
      ),
    );
  }
}