import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: AppBar(
            flexibleSpace: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: const Text(
                  "Appbar with custom height",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
                ),
              ) 
            ),
          ),
        ),
      ),
    );
  }
}