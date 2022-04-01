import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/login_page.dart';
import 'package:hello_flutter/main_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: LoginPage(),
    );
  }
}