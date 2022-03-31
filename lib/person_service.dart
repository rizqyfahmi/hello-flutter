import 'dart:convert';
import 'dart:io';
import 'package:hello_flutter/person.dart';
import 'package:http/http.dart' as http;

class PersonService {
  static Future<Person> getPersonById(String id, http.Client client) async {
    final uri = Uri.parse("https://localhost/person/$id");
    final response = await client.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Error");
    }

    final result = json.decode(response.body);

    return Person.fromJson(result);
  }
}