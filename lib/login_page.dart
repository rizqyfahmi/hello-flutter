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
            )
          ],
        ),
      ),
    );
  }
}