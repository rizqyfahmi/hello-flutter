import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/third_page.dart';

import 'main_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({ Key? key }) : super(key: key);

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
            ElevatedButton(
              onPressed: () {
                Get.back<String>(result: "Hello World");
              } , 
              child: const Text("Back to previous page")
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/third?language=Indonesia", arguments: ["Hello", "World"]);
              } , 
              child: const Text("Third Page")
            ),
          ],
        ),
      ),
    );
  }
}