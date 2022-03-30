import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "assets/env/.env_production");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: (dotenv.env["MODE"] ?? "") == "development",
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dot env demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${dotenv.env["MODE"]}",style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("${dotenv.env["LANGUAGE"]}",style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey))
          ],
        ),
      ),
    );
  }
}