import 'package:flutter/material.dart';
import 'package:hello_flutter/model/todo.dart';

class TodoNotifier extends ChangeNotifier {
  final List<Todo> todos = [];

  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

  void removeTodo(String todoId) {
    todos.remove(todos.firstWhere((element) => element.id == todoId));
    notifyListeners();
  }
  
  void toggleTodo(String todoId) {
    for (final Todo todo in todos) {
      if (todo.id == todoId) {
        todo.completed = !todo.completed;
        notifyListeners();
        break;
      }
    }
  }
}