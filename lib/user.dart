import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String name;

  User({ required this.id, required this.name });

  factory User.createUser(Map<String, dynamic> data) {
    return User(
      id: data["id"],
      name: data["name"]
    );
  }

  static Future<List<User>> getListFromAPI({int page = 1}) async {
    final uri = Uri(
      scheme: "https",
      host: "reqres.in",
      path: "api/users?page=$page"
    );

    final response = await http.get(uri);
    final body = json.decode(response.body);
    final List<dynamic> data = (body as Map<String, dynamic>)["data"];
    // Convert dynamic into List of Map<String, dynamic> using "from"
    final List<Map<String, dynamic>> mapData = List<Map<String, dynamic>>.from(data);
    final List<User> users = mapData.map((row) => User.createUser(row)).toList();
    return users;

  }
}