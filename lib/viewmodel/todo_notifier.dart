import 'dart:convert';

import 'package:hello_flutter/model/todo.dart';
import 'package:http/http.dart' as http;

class TodoNotifier {
  Future<List<Todo>> getTodos() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
    if (response.statusCode != 200) {
      throw Exception('Failed to load Todo');
    }

    final body = jsonDecode(response.body);
    final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(body);
    final List<Todo> todos = data.map((element) {
      return Todo(id: "${element["id"]}", description: element["title"], completed: element["completed"]);
    }).toList();

    return todos;
  }
}