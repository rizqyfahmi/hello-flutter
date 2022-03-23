import 'package:flutter/material.dart';
import 'dart:math';

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
            body: Column(
                children: [
                    Flexible(
                        flex: 1,
                        child: Row(
                            children: [
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                        color: Colors.brown,
                                    )
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                        color: Colors.teal,
                                    )
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                        color: Colors.redAccent,
                                    )
                                )
                            ],
                        ),
                    ),
                    Flexible(
                        flex: 2,
                        child: Container(
                            color: Colors.purple,
                        ),
                    ),
                    Flexible(
                        flex: 1,
                        child: Container(
                            color: Colors.lime,
                        ),
                    ),
                ],
            ),
        ),
    );
  }
}