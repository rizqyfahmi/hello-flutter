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
                    // Container is used to make us can implement padding, margin, background, etc to its child
                    child: Container(
                        color: Colors.lightBlue,
                        width: 150,
                        height: 100,
                        child: const Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 20
                            ),
                        ),
                    ),
                ),
            ),
        );
    }
}