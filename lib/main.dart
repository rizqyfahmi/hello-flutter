import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_flutter/model/todo.dart';
import 'package:hello_flutter/viewmodel/todo_notifier.dart';

/*
  It is typically used for:
  - Performing and caching asynchronous operations (such as network requests)
  - Nicely handling error/loading states of asynchronous operations
  - Combining multiple asynchronous values into another value
*/ 
final todoProvider = FutureProvider<List<Todo>>((ref) async => TodoNotifier().getTodos());

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
    AsyncValue<List<Todo>> todo = ref.watch(todoProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod's FutureProvider"),
      ),
      body: todo.when(data: (todos) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return Text(todos[index].description);
                },
              ),
            ),
          ],
        );
      }, error: (err, stack) {
        return Text('Error: $err');
      }, 
      loading: () {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
            ],
          )
        );
      })
    );
  }
}