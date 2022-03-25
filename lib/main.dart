import 'package:flutter/material.dart';
import 'package:hello_flutter/colorful_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Transform Application"),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ColorfulButton(
                mainColor: Colors.pink,
                secondColor: Colors.blue,
                icon: Icons.adb
              )
            ],
          ),
        ),
      ),
    );
  }
}