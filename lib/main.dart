import 'package:flutter/material.dart';
import 'package:hello_flutter/color_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ColorBloc bloc = ColorBloc();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("BLoC Application"),
        ),
        body: Center(
          child: StreamBuilder<Color>(
            stream: bloc.stateStream,
            initialData: Colors.amber,
            builder: (context, snapshot) {
              return AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: 150,
                width: 150,
                color: snapshot.data,
              );
            }
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () {
                bloc.eventSink.add(ColorEvent.toAmber);
              }
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              backgroundColor: Colors.lightBlue,
              onPressed: () {
                bloc.eventSink.add(ColorEvent.toLightBlue);
              }
            ),
          ],
        ),
      ),
    );
  }
  
}