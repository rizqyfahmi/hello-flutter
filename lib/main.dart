import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
  - This is pretty much the most basic kind of Provider
  - It can hold any type of data but it isn't very complex
  - It can't change it from the outside, like somewhere in your Widget's build method
  - We can use ref.watch to monitor other Providers and change its value from inside it though
*/ 
final helloProvider = Provider((ref) => "Hello World");

void main() async {
  // For widgets to be able to read providers, we need to wrap the entire application in a "ProviderScope" widget.
  // This is where the state of our providers will be stored.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String hello = ref.watch(helloProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod's Provider"),
      ),
      body: Center(
        child: Text(
          hello,
          style: const TextStyle(
            fontSize: 18
          ),
        ),
      ),
    );
  }
}