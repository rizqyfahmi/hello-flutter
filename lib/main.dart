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
    int number = 0;

    void onIncreament() {
        setState(() {
            number += 1;
        });
    }
    
    void onDecreament() {
        if (number == 0) return;

        setState(() {
            number -= 1;
        });
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                    title: const Text("Hello World Application"),
                ),
                body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Text(
                                "$number",
                                style: TextStyle(fontSize: 16 + number.toDouble()),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Container(
                                        margin: const EdgeInsets.all(8),
                                        child: ElevatedButton(
                                            onPressed: onIncreament, child: const Text("Up")
                                        ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.all(8),
                                        child: ElevatedButton(
                                            onPressed: onDecreament, child: const Text("Down")
                                        ),
                                    )
                                ],
                            )
                        ],
                    ),
                ),
            ),
        );
    }
}