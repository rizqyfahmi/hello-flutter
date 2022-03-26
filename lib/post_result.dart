import 'dart:convert';
import 'package:http/http.dart' as http;

class PostResult {
  final String id;
  final String name;
  final String job;
  final String created;

  PostResult({ required this.id, required this.name, required this.job, required this.created });

  factory PostResult.createPostResult(Map<String, dynamic> result) {
    return PostResult(id: result["id"], name: result["name"], job: result["job"], created: result["createdAt"]);
  }

  static Future<PostResult> saveToAPI(String name, String job) async {

    final url = Uri(
        scheme: 'https',
        host: 'reqres.in',
        path: 'api/users',
        fragment: 'numbers');

    final response = await http.post(url, body: { "name": name, "job": job });
    final data = json.decode(response.body);

    return PostResult.createPostResult(data);
  }
}