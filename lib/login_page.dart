import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

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
                Get.offNamed("/main");
              }, 
              child: const Text("Login")
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Note that we must use GetMaterialApp
                Get.snackbar(
                  "Hello Title", 
                  "Hello Message",
                  snackPosition: SnackPosition.BOTTOM,
                  snackStyle: SnackStyle.FLOATING,
                );
              },
              child: const Text("Open SnackBar")
            )
          ],
        ),
      ),
    );
  }
}