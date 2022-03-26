import 'package:flutter/material.dart';
import 'package:hello_flutter/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<User> users = [];

  List<Widget> buildList() {
    return users.map((user) => Text(user.name)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("ClipPath Image"),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final data = await User.getListFromAPI(page: 1);
                  setState(() {
                    users = data;
                  });
                }, 
                child: const Text("GET DATA")
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  children: buildList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
