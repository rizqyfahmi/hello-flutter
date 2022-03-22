import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({ Key? key }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        // Material App is used to make an application based on material design where we can set initial route, option routes, theme(dark, light), etc.
        return MaterialApp(
            // Scaffold is used to be template for android aplication where we can set appBar, body, etc.
            home: Scaffold(
                appBar: AppBar(
                    title: const Text("Hello world application"),
                ),
                //  Center is a widget that centers its child
                body: Center(
                    // Column is a widget used to display its children vertically
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                            const Text("Text 1"),
                            const Text("Text 2"),
                            const Text("Text 3"),
                            // Row is a widget used to display its children horizontally
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                    Text("Text 4"),
                                    Text("Text 5"),
                                    Text("Text 6"),
                                ],
                            )
                        ],
                    )
                ),
            ),
        );
    }
}