import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/color_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColorBloc(Colors.amber),
      child: const MaterialApp(
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorBloc bloc = BlocProvider.of<ColorBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter BLoC"),
      ),
      body: Center(
        child: BlocBuilder<ColorBloc, Color>(
          builder: (context, state) => AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: 100,
            width: 100,
            color: state,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: () {
              bloc.add(ColorAmber());
            },
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            onPressed: () {
              bloc.add(ColorLightBlue());
            },
          ),
        ],
      ),
    );
  }
}