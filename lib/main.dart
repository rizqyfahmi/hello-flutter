import 'package:flutter/material.dart';
import 'package:hello_flutter/profile.dart';

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
          title: const Text("Doc Comments"),
        ),
        body: const Center(
          child: Profile(),
        ),
      ),
    );
  }
}