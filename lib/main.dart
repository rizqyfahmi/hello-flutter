import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return const MaterialApp(
            home: MainPage(),
        );
    }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    Random random = Random();
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text("Media Query Screen Size"),
            ),
            body: (MediaQuery.of(context).orientation == Orientation.portrait) ? (
                Column(
                    children: List.generate(3, (index) => Container(
                        width: 100,
                        height: 100,
                        color: Color.fromARGB(255, random.nextInt(256), random.nextInt(256), random.nextInt(256)),
                    )),
                )
            ) : (
                Row(
                    children: List.generate(3, (index) => Container(
                        width: 100,
                        height: 100,
                        color: Color.fromARGB(255, random.nextInt(256), random.nextInt(256), random.nextInt(256)),
                    ))
                )
            ),
        );
    }
}