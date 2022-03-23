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
            body: Container(
                width: double.infinity,
                color: Colors.amber,
                child: Column(
                    children: [
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                                color: Colors.green,
                                child: Row(
                                    children: const [
                                        // Spacer is a widget used to add space that fills remain space
                                        Spacer(flex: 1),
                                        //network
                                        Image(
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.contain,
                                            repeat: ImageRepeat.noRepeat,
                                            image: NetworkImage(
                                                "https://cdn-icons-png.flaticon.com/128/3917/3917032.png"
                                            ),
                                        ),
                                        // Spacer is a widget used to add space that fills remain space
                                        Spacer(),
                                    ],
                                ),
                            )
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                                color: Colors.red,
                                child: Row(
                                  children: const [
                                        // Spacer is a widget used to add space that fills remain space
                                        Spacer(),
                                        // local
                                        Image(
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.contain,
                                            repeat: ImageRepeat.noRepeat,
                                            image: AssetImage("images/paper-plane.png"),
                                        ),
                                        // Spacer is a widget used to add space that fills remain space
                                        Spacer(),
                                  ],
                                ),
                            ),
                        )
                    ],
                ),
            ),
        ),
    );
  }
}