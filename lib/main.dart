import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_flutter/model/todo.dart';
import 'package:hello_flutter/viewmodel/todo_notifier.dart';

/*
  It is typically used for:
  - It can be used for more complex data
  - Centralizing the logic for modifying some state (aka "business logic") in a single place, improving maintainability over time
  - Exposing an mutable state (Downside: We are able to change the state make it harder to maintain)
    Downside:
    - We need to manually notify for updates using the notifyListeners method
    - We are able to change the state make it harder to maintain. This will change the state from 
      outside without notifying our listeners and hence the UI won't rebuild then we can't see the change of state in the UI
*/ 
final todoProvider = ChangeNotifierProvider<TodoNotifier>((ref) => TodoNotifier());

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
    List<Todo> todos = ref.watch<TodoNotifier>(todoProvider).todos;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod's ChangeNotifierProvider"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  final random = Random();
                  final randomResult = random.nextInt(100) + 10;
                  final todo = Todo(id: "$randomResult", description: "$randomResult", completed: false);
                  ref.read(todoProvider).addTodo(todo);
                  // we can do this but it won't change the UI because we don't do notifyListeners()
                  // ref.read(todoProvider).todos.add(todo);
                }, 
                child: const Text("Generate Todo")
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: Text("${todos[index].description} ${todos[index].completed}"),
                        value: todos[index].completed, 
                        onChanged: (_) => {
                          ref.read(todoProvider).toggleTodo(todos[index].id)
                        }
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(todoProvider).removeTodo(todos[index].id);
                      }, 
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      )
                    )
                  ],
                );
              },
            ),
          )
        ],
      )
    );
  }
}