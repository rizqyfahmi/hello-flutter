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
  bool isActive = false;
  Widget switcherWidget = Container(
    height: 100,
    width: 200,
    color: Colors.red,
  );
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Switch and AnimatedSwitcher"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  transitionBuilder: (widget, animation) => RotationTransition(
                    turns: animation,
                    child: widget,
                  ),
                  child: switcherWidget,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  activeColor: Colors.green,
                  activeTrackColor: Colors.green.withOpacity(0.3),
                  inactiveThumbColor: Colors.red,
                  inactiveTrackColor: Colors.red.withOpacity(0.5),
                  value: isActive, 
                  onChanged: (value) {
                    if (value) {
                      return setState(() {
                        isActive = value;
                        switcherWidget = Container(
                          key: const ValueKey(1), // we need to put key when we use same widget (Container vs Container, etc)
                          height: 100,
                          width: 200,
                          color: Colors.green,
                        );
                        // switcherWidget = const SizedBox(
                        //   height: 100,
                        //   width: 200,
                        //   child: Center(
                        //     child: Text("Switch On"),
                        //   )
                        // );
                      });  
                    }

                    setState(() {
                      isActive = value;
                      switcherWidget = Container(
                        key: const ValueKey(2), // we need to put key when we use same widget (Container vs Container, etc)
                        height: 100,
                        width: 200,
                        color: Colors.red,
                      );
                    });
                  }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}