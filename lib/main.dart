import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({ Key? key }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        // Material App is used to make an application based on material design where we can set initial route, option routes, theme(dark, light), etc.
        return MaterialApp(
            // Scaffold is used to be template for android aplication where we can set appBar, body, etc.
            home: Scaffold(
                appBar: AppBar(
                    title: const Text("Hello world application"),
                ),
                // Container is used to make us can implement padding, margin, background, etc to its child
                body: Container(
                    color: Colors.blueAccent,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(16),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                                colors: [
                                    Colors.lime,
                                    Colors.cyan,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight
                            )
                        ),
                    ),
                )
            ),
        );
    }
}