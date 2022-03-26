import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  TextEditingController controller = TextEditingController();

  void setData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("name", controller.text);
    pref.setBool("isActive", isActive);
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      controller.text = pref.getString("name") ?? "";
      isActive = pref.getBool("isActive") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Shared Preferences App"),
        ),
        body: Column(
          children: [
            TextField(
              controller: controller,
            ),
            Switch(
              value: isActive,
              onChanged: (value) {
                setState(() {
                  isActive = value;
                });
              }
            ),
            ElevatedButton(
              onPressed: () {
                setData();
              },
              child: const Text("Save Data")
            ),
            ElevatedButton(
              onPressed: () {
                getData();
              },
              child: const Text("Load Data")
            ),
          ],
        )
      ),
    );
  }
}