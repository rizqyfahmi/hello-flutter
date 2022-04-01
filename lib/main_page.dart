import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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