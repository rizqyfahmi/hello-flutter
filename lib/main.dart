import 'package:flutter/material.dart';
import 'package:hello_flutter/application_color.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ChangeNotifierProvider is a widget used to provide an instance of ApplicationColor (state class)
      home: ChangeNotifierProvider<ApplicationColor>(
        create: (context) => ApplicationColor(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            // Consumer is a widget used to watch/consume the changes that comes from ApplicationColor
            title: Consumer<ApplicationColor>(
              builder: (context, applicationColor, _) => Text(
                "Provider State Management",
                style: TextStyle(
                  color: applicationColor.getColor()
                ),
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Consumer is a widget used to watch/consume the changes that comes from ApplicationColor
              Consumer<ApplicationColor>(
                builder: (context, applicationColor, _) => AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 100,
                  width: 100,
                  color: applicationColor.getColor(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("AB"),
                  // Consumer is a widget used to watch/consume the changes that comes from ApplicationColor
                  Consumer<ApplicationColor>(
                    builder: (context, applicationColor, _) => Switch(
                      value: applicationColor.isLight,
                      onChanged: (value) {
                        applicationColor.isLight = value;
                      }
                    ),
                  ),
                  const Text("LB")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}