import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_flutter/model/todo.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    state = state.where((element) => element.id != todoId).toList();
  }
  
  void toggleTodo(String todoId) {
    state = state.map((element) {
      if (element.id == todoId) {
        return element.copyWith(completed: !element.completed);
      }
      return element;
    }).toList();
  }
}