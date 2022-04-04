import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage()
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

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this
    );

    // We don't have to call setState();
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Basic"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: RotatedContainer(animation: _animation),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {
                    _controller.forward();
                  }, 
                  child: const Text("Play")
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: () {
                    _controller.repeat();
                  }, 
                  child: const Text("Play Repeatedly")
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: () {
                    _controller.stop();
                  }, 
                  child: const Text("Stop")
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// AnimatedWidget is an abstract class that let us to seperated a specific custom animation that we build
class RotatedContainer extends AnimatedWidget {
  const RotatedContainer({
    Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);


  @override
  Widget build(BuildContext context) {
    Animation animation = listenable as Animation<double>;

    return Transform.rotate(
      angle: animation.value,
      child: Container(
        height: 100,
        width: 100,
        color: Colors.green,
      ),
    );
  }
}