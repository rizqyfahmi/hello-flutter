import 'package:flutter/material.dart';
import 'package:hello_flutter/login_page.dart';
import 'package:hello_flutter/main_page.dart';
import 'package:hello_flutter/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const LoginPage(),
        routes: {
            LoginPage.routeName: (context) => const LoginPage(),
            MainPage.routeName: (context) => const MainPage(),
            SecondPage.routeName: (context) => const SecondPage(),
        },
    );
  }
}