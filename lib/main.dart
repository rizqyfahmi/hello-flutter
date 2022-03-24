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
                title: const Text("Hello world application"),
            ),
            body: Column(
                children: [
                    buildCard(Icons.account_box, "Account Box"),
                    buildCard(Icons.android, "Android")
                ],
            ),
        ),
    );
  }

  Card buildCard(IconData icon, String text) {
    // Card is a widget used to create card like a panel in bootstrap
    return Card(
        color: Colors.white,
        elevation: 5,
        margin: const EdgeInsets.all(6),
        child: Row(
            children: [
                Container(
                    margin: const EdgeInsets.all(6),
                    child: Icon(icon),
                ),
                Text(text)
            ],
        ),
    );
  }
}