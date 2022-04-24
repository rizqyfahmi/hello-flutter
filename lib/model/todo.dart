import 'package:flutter/material.dart';

@immutable
class Todo {
  String id;
  String description;
  bool completed;

  Todo({
    required this.id,
    required this.description,
    required this.completed
  });

  Todo copyWith({
    String? id, String? description, bool? completed
  }) {
    return Todo(
      id: id ?? this.id, 
      description: description ?? this.description, 
      completed: completed ?? this.completed
    );
  }
}