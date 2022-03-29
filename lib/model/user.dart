import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final int id;
  final String email;
  final String name;
  final String avatarUrl;

  User({ this.id = -1, this.email = "", this.name = "", this.avatarUrl = "" });

  factory User.createUser(Map<String, dynamic> response) {
    return User(
      id: response["id"],
      email: response["email"],
      name: "${response["first_name"]} ${response["last_name"]}",
      avatarUrl: response["avatar"],
    );
  }

  static Future<User> getFromAPI({ int id = 1 }) async {
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

class UninitializedUser extends User {}