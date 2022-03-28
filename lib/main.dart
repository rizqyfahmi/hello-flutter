import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? timer;
  String textButton = "Start";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<TimeState>(
        create: (context) => TimeState(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Custom Progress Bar"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<TimeState>(
                  builder: (context, timeState, _) => CustomProgressBar(
                    width: 150,
                    currentValue: timeState.time,
                    totalValue: 100,
                  ),
                ),
                Consumer<TimeState>(
                  builder: (context, timeState, _) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (timer != null) {
                            timer?.cancel();
                            timer = null;
                            setState(() {
                              textButton = "Start";
                            });
                            return;
                          }

                          timer = Timer.periodic(const Duration(seconds: 1), (tm) {
                            if (timeState.time > 0) {
                              timeState.time -= 10;
                              return;
                            }

                            tm.cancel();
                            timer = null;
                            setState(() {
                              textButton = "Start";
                            });
                          });

                          setState(() {
                            textButton = "Stop";
                          });
                        },
                        child: Text(textButton)
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          timeState.time = 100;
                        },
                        child: const Text("Reset")
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  final double? width;
  final double currentValue;
  final double totalValue;

  const CustomProgressBar({ Key? key, this.width, required this.currentValue, required this.totalValue }) : super(key: key);

  Color getProgressColor(double progress) {
    if (progress < 30) {
      return Colors.red;
    }

    if (progress < 50) {
      return Colors.yellow;
    }

    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.timer),
        const SizedBox(width: 10),
        Stack(
          children: [
            Container(
              width: width,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300]
              ),
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(5),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: (currentValue / totalValue) * (width ?? 1),
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: getProgressColor((currentValue / totalValue) * 100)
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class TimeState with ChangeNotifier {
  double _time = 100;

  double get time => _time;
  set time(double value) {
    _time = value;
    notifyListeners();
  }
}