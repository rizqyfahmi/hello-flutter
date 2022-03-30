import 'dart:convert';

import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String title, body;

  Post({required this.id, required this.title, required this.body});

  static Future<List<Post>> getFromAPI({ int start = 0, int limit = 10 }) async {
    final uri = Uri(
      scheme: "https",
      host: "jsonplaceholder.typicode.com",
      path: "/posts",
      queryParameters: {
        "_start": start.toString(),
        "_limit": limit.toString()
      }
    );

    final response = await http.get(uri);
    final body = json.decode(response.body) as List;
    final data = body.map<Post>((item) => Post(id: item["id"], title: item["title"], body: item["body"])).toList(); 

    return data;
  }

}