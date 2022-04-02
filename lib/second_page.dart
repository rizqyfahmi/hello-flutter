import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/controllers/counter_reactive_controller.dart';
import 'package:hello_flutter/third_page.dart';

import 'main_page.dart';

class SecondPage extends StatelessWidget {
  final controller = Get.put(CounterReactiveController());

  SecondPage({ Key? key }) : super(key: key);

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
            Obx(() {
              return Text(
                "${controller.amount}",
                style: const TextStyle(fontSize: 50)
              );
            }),
            const SizedBox(width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                    heroTag:
                        "btn-increament", // Add this line to avoid error "There are multiple heroes that share the same tag within a subtree"
                    child: const Icon(Icons.arrow_upward),
                    onPressed: () {
                      controller.increament();
                    }),
                const SizedBox(width: 10),
                FloatingActionButton(
                    heroTag:
                        "btn-decreament", // Add this line to avoid error "There are multiple heroes that share the same tag within a subtree"
                    child: const Icon(Icons.arrow_downward),
                    onPressed: () {
                      controller.decreament();
                    })
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
                  child: const Text("Third Page")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}