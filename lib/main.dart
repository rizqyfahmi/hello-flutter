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
  List<bool> isSelected = [false, true, false];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.green, BlendMode.color),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Hello world application"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SelectableText is a widget used to display text but it can be selectable using finger
                const SelectableText(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                  showCursor: true,
                ),
                // It is like group button in bootstrap
                ToggleButtons(
                  children: const [
                    Icon(Icons.adb),
                    Icon(Icons.ac_unit_sharp),
                    Icon(Icons.account_balance_wallet_sharp),
                  ], 
                  isSelected: isSelected,
                  onPressed: (index) {
                    setState(() {
                      for (var i = 0; i < isSelected.length; i++) {
                        if (index == i) {
                          isSelected[index] = !isSelected[index];
                          continue;
                        }
      
                        isSelected[i] = false;
                      }
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}