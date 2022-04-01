import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/main_page.dart';

class ThirdPage extends StatelessWidget {
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