import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Data {
    final Color color;
    final String message;

    Data({this.color = Colors.black12, this.message = ""});
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    Color? targetColor;
    
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                    title: const Text("Hello world application"),
                ),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children:  [
                                    Draggable<Data>(
                                        data: Data(message: "Hello Red", color: Colors.redAccent),
                                        // SizedBox is a widget seams like container but it only has widget and height property
                                        child: const SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Material(
                                                color: Colors.redAccent,
                                                shape: StadiumBorder(),
                                                elevation: 3,
                                            ),
                                        ),
                                        // SizedBox is a widget seams like container but it only has widget and height property
                                        feedback: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Material(
                                                color: Colors.redAccent.withOpacity(0.7),
                                                shape: const StadiumBorder(),
                                                elevation: 3,
                                            ),
                                        ),
                                        // SizedBox is a widget seams like container but it only has widget and height property
                                        childWhenDragging: const SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: null,
                                        ),
                                    ),
                                    Draggable<Data>(
                                        data: Data(message: "Hello Green", color: Colors.greenAccent),
                                        // SizedBox is a widget seams like container but it only has widget and height property
                                        child: const SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Material(
                                                color: Colors.greenAccent,
                                                shape: StadiumBorder(),
                                                elevation: 3,
                                            ),
                                        ),
                                        // SizedBox is a widget seams like container but it only has widget and height property
                                        feedback: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Material(
                                                color: Colors.greenAccent.withOpacity(0.7),
                                                shape: const StadiumBorder(),
                                                elevation: 3,
                                            ),
                                        ),
                                        // SizedBox is a widget seams like container but it only has widget and height property
                                        childWhenDragging: const SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: null,
                                        ),
                                    )
                                ],
                            ),
                        ),
                        Flexible(
                            flex: 1,
                            child: DragTarget(
                                onWillAccept: (_) => true,
                                onAccept: (data) => {
                                    setState(() {
                                        targetColor = (data as Data).color;
                                    })
                                },
                                builder: (context, candidates, rejected) {
                                    if (targetColor == null) {
                                        return Container(
                                            color: Colors.black12,
                                        );
                                    }
                            
                                    return Container(
                                        color: targetColor,
                                    );
                                },
                            ),
                        )
                    ]
                ),
            )
        );
    }
}