import 'package:flutter/material.dart';
import 'dart:developer';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: const Text("Hello world application"),
            ),
            body: const Center(
                child: Text(
                    "Hello World",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.overline,
                        decorationColor: Colors.green,
                        decorationThickness: 5,
                        decorationStyle: TextDecorationStyle.wavy
                    ),
                ),
            ),
        ),
    );
  }
}