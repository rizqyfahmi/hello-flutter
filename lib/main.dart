import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/fourth_page.dart';
import 'package:hello_flutter/login_page.dart';
import 'package:hello_flutter/main_page.dart';
import 'package:hello_flutter/second_page.dart';
import 'package:hello_flutter/third_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/login",
      getPages: [
        GetPage(name: "/login", page: () => const LoginPage(), transition: Transition.zoom),
        GetPage(name: "/main", page: () => MainPage()),
        GetPage(name: "/second", page: () => SecondPage()),
        GetPage(name: "/third", page: () => ThirdPage()),
        GetPage(name: "/fourth", page: () => FourthPage())
      ],
    );
  }
}