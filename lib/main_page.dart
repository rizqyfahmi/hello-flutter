import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/controllers/counter_simple_controller.dart';
import 'package:hello_flutter/second_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({ Key? key }) : super(key: key);

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
            // In the simple state management approach we use GetBuilder to observe the change of state
            GetBuilder<CounterSimpleController>(
              init: CounterSimpleController(),
              builder: (controller) => Text(
                "${controller.counter.amount}",
                style: const TextStyle(
                  fontSize: 50
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                    heroTag: "btn-increament", // Add this line to avoid error "There are multiple heroes that share the same tag within a subtree"
                    child: const Icon(Icons.arrow_upward),
                    onPressed: () {
                      Get.find<CounterSimpleController>().increament();
                    }),
                const SizedBox(width: 10),
                FloatingActionButton(
                    heroTag: "btn-decreament", // Add this line to avoid error "There are multiple heroes that share the same tag within a subtree"
                    child: const Icon(Icons.arrow_downward),
                    onPressed: () {
                      Get.find<CounterSimpleController>().decreament();
                    })
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final result = await Get.toNamed("/second");
                log("====> $result");
              } , 
              child: const Text("Second Page")
            )
          ],
        ),
      ),
    );
  }
}