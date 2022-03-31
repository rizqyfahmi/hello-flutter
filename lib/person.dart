import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final int id;
  final String name;
  final int age;

  const Person({required this.id, required this.name, required this.age});

  factory Person.fromJson(Map<String, dynamic> data) {
    return Person(id: data["id"], name: data["name"], age: data["age"]);
  }

  @override
  List<Object?> get props => [id, name, age];
  
}