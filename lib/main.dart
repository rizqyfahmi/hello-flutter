import 'package:flutter/material.dart';
import 'dart:developer';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    List<Widget> widgets = [];

    _MyAppState() {
        widgets = [
            ...List.generate(50, (index) {
                return Text(
                    "Hello ${index + 1}", 
                    style: const TextStyle(fontSize: 20),
                );
            })
        ];
    }

    @override
    Widget build(BuildContext context) { 
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(title: const Text("Hello world application")),
                // ListView is a widget used to make the screen is scrollable when it has set of widgets that make it overflow
                body: ListView(
                    children: [
                        Column(
                            children: widgets,
                        )
                    ],
                ),
            ),
        );
    }
}