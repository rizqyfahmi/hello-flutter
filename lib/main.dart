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
  User? user;

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
              Text((user != null) ? "${user?.id} - ${user?.name}" : "Tidak ada data"),
              ElevatedButton(
                onPressed: () async {
                  final data = await User.getFromAPI(2);
                  setState(() {
                    user = data;
                  });
                }, 
                child: const Text("GET DATA")
              )
            ],
          ),
        ),
      ),
    );
  }
}
