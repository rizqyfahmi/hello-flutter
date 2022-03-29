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
  final List<String> names = ["John", "Siera", "Monica"];
  String? selectedName;

  List<DropdownMenuItem<String>> buildDropdownMenuItem(List<String> names) {
    return names.map((String name) => (
      DropdownMenuItem<String>(
        child: Text(name),
        value: name,
      )
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("DropdownButton Demo"),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                items: buildDropdownMenuItem(names),
                value: selectedName,
                onChanged: (String? value) {
                  setState(() {
                    selectedName = value;
                  });
                }
              ),
              Text(selectedName ?? "Belum ada yang terpilih")
            ],
          ),
        ),
      )
    );
  }
}