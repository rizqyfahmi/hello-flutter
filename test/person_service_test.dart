import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter/person.dart';
import 'package:http/http.dart' as http;
import 'package:hello_flutter/person_service.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {
  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return super.noSuchMethod(Invocation.method(#get, [url, headers]), returnValue: Future.value(
      http.Response('''
      {
        "message": "Page not found"
      }
      ''', 404)
    ));
  }
}
void main() {
  http.Client client = MockClient();

  test("Get Data", () async {
    String id = "1";
    final uri = Uri.parse("https://localhost/person/$id");
    when(client.get(uri)).thenAnswer((_) async => http.Response('''{
      "id": $id,
      "name": "John",
      "age": 20
    }''', 200));

    Person person = await PersonService.getPersonById(id, client);
    expect(person, equals(const Person(id: 1, name: "John", age: 20)));
  });

  test("Get Data Error", () async {
    String id = "1";
    final uri = Uri.parse("https://localhost/person/$id");
    when(client.get(uri)).thenAnswer((_) async => http.Response('''{
      "message": "Error"
    }''', 404));

    expect(PersonService.getPersonById(id, client), throwsException);
  });
}