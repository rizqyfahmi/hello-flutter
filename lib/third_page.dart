import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/controllers/counter_mix_controller.dart';
import 'package:hello_flutter/main_page.dart';

class ThirdPage extends StatelessWidget {
  final ctrl = Get.put(CounterMixController());

  ThirdPage({ Key? key }) : super(key: key) {
    
    log("${Get.arguments.toString()}");
    log("${Get.parameters.toString()}");
  }

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
            MixinBuilder<CounterMixController>(
              init: CounterMixController(),
              builder: (controller) {
                return Column(
                  children: [
                    Text(
                      controller.title,
                      style: const TextStyle(fontSize: 30)
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${controller.amount.value}",
                      style: const TextStyle(fontSize: 50)
                    )
                  ],
                );
              },
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
                    ctrl.increament();
                  }
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  heroTag:
                      "btn-decreament", // Add this line to avoid error "There are multiple heroes that share the same tag within a subtree"
                  child: const Icon(Icons.arrow_downward),
                  onPressed: () {
                    ctrl.decreament();
                  }
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: "btn-uppercase", // Add this line to avoid error "There are multiple heroes that share the same tag within a subtree"
                  child: const Icon(Icons.sunny),
                  onPressed: () {
                    ctrl.convertToUppercase();
                  }
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: "btn-lowercase", // Add this line to avoid error "There are multiple heroes that share the same tag within a subtree"
                  child: const Icon(Icons.bedtime),
                  onPressed: () {
                    ctrl.convertToLowercase();
                  }
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back<String>(result: "Hello World");
                  } , 
                  child: const Text("Back to previous page")
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/third?language=Indonesia",
                        arguments: ["Hello", "World"]);
                  },
                  child: const Text("Fourth Page")
                ),
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