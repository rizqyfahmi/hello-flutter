import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/fourth_page.dart';
import 'package:hello_flutter/login_page.dart';
import 'package:hello_flutter/main_page.dart';
import 'package:hello_flutter/route_name.dart' ;
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
        GetPage(name: RouteName.login, page: () => const LoginPage(), transition: Transition.zoom),
        GetPage(name: RouteName.main, page: () => const MainPage()),
        GetPage(name: RouteName.second, page: () => SecondPage()),
        GetPage(name: "${RouteName.third}/:id/:country?", page: () => ThirdPage()),
        GetPage(name: RouteName.fourth, page: () => FourthPage())
      ],
    );
  }
}