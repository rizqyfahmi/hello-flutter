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
    TextEditingController controller = TextEditingController();

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                    title: const Text("Hello world application"),
                ),
                body: Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                            TextField(
                                decoration: InputDecoration(
                                    icon: const Icon(Icons.access_alarm),
                                    // prefix: Container(width: 10, height: 10, color: Colors.green,),
                                    prefixIcon: const Icon(Icons.adb),
                                    prefixText: "Name: ",
                                    prefixStyle: const TextStyle(color: Colors.lightBlue),
                                    labelText: "Fullname: ", // we must focus it to make it up
                                    labelStyle: const TextStyle(color: Colors.blueAccent),
                                    // suffix: Container(width: 10, height: 10, color: Colors.green,),
                                    hintText: "Enter a name...",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                                controller: controller,
                                onChanged: (value) {
                                    setState(() {});
                                },
                            ),
                            Text(controller.text)
                        ],
                    ),
                )
            ),
        );
    }
}