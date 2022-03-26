import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final int id;
  final String name;

  User({ required this.id, required this.name });

  factory User.createUser(Map<String, dynamic> data) {
    return User(
      id: data["id"],
      name: "${data["first_name"]} ${data["last_name"]}"
    );
  }

  static Future<User> getFromAPI(int id) async {
    
    final uri = Uri(
      scheme: "https",
      host: "reqres.in",
      path: "api/users/$id"
    );

    final response = await http.get(uri);
    final body = json.decode(response.body);
    final data = (body as Map<String, dynamic>)["data"];

    return User.createUser(data);

  }
}