import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double padding = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("AnimatedPadding"),
        ),
        body: GestureDetector(
          onTap: () {
            Random random = Random();
            setState(() {
              padding = double.parse((10 + random.nextInt(30)).toString());
            });
          },
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AnimatedPadding(
                        duration: const Duration(seconds: 1),
                        padding: EdgeInsets.all(padding),
                        child: Container(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AnimatedPadding(
                        duration: const Duration(seconds: 1),
                        padding: EdgeInsets.all(padding),
                        child: Container(
                          color: Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AnimatedPadding(
                        duration: const Duration(seconds: 1),
                        padding: EdgeInsets.all(padding),
                        child: Container(
                          padding: EdgeInsets.all(padding),
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AnimatedPadding(
                        duration: const Duration(seconds: 1),
                        padding: EdgeInsets.all(padding),
                        child: Container(
                          padding: EdgeInsets.all(padding),
                          color: Colors.yellow,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}