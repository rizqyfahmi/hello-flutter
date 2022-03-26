import 'package:flutter/material.dart';
import 'package:hello_flutter/post_result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PostResult? postResult;

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
              Text((postResult != null) ? "${postResult?.id} - ${postResult?.name} - ${postResult?.job} - ${postResult?.created}" : "Tidak ada data"),
              ElevatedButton(
                onPressed: () async {
                  final data = await PostResult.saveToAPI("John", "Supervisor");
                  setState(() {
                    postResult = data;
                  });
                }, 
                child: const Text("POST DATA")
              )
            ],
          ),
        ),
      ),
    );
  }
}
