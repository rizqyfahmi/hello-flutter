import 'package:flutter/material.dart';

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
                title: const Text("AppBar Example"),
                flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                                Color(0xff0096ff),
                                Color(0xff6610f2)
                            ],
                            begin: FractionalOffset.centerLeft,
                            end: FractionalOffset.centerRight,
                        ),
                        image: DecorationImage(
                            image: AssetImage("images/pattern.png"), 
                            repeat: ImageRepeat.repeat
                        )
                    ),
                ),
            ),
        )
    );
  }
}