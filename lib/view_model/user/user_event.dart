import 'package:equatable/equatable.dart';

class UserEvent extends Equatable {
  @override
  List<Object?> get props => []; // used to list some property that we want to compare
}

class UserGenerateRandom extends UserEvent {
  final int id;
  
  UserGenerateRandom(this.id);

  @override
  List<Object?> get props => [id]; // used to list some property that we want to compare

}