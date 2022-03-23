import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:developer' as developer;

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
            body: Stack(
                children: [
                    Column(
                        children: [
                            Flexible(
                                flex: 1,
                                child: Row(
                                    children: [
                                        Flexible(
                                            child: Container(
                                                color: Colors.white,
                                            ),
                                        ),
                                        Flexible(
                                            child: Container(
                                                color: Colors.black12,
                                            ),
                                        )
                                    ],
                                )
                            ),
                            Flexible(
                                flex: 1,
                                child: Row(
                                children: [
                                    Flexible(
                                        child: Container(
                                            color: Colors.black12,
                                        ),
                                    ),
                                    Flexible(
                                        child: Container(
                                            color: Colors.white,
                                        ),
                                    )
                                    ],
                                )
                            )
                        ],
                    ),
                    ListView(
                        children: List.generate(100, (index) => Text(
                            "Hello World for ${index + 1}",
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 20
                            ),
                        )),
                    ),
                    SafeArea(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                                child: const Text("Press Me!"),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.green)
                                ),
                                onPressed: () {
                                    developer.log("Hello");
                                }
                            ),
                        )
                    )
                ],
            ),
        ),
    );
  }
}