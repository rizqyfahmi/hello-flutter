import 'package:equatable/equatable.dart';

class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostGetInitialEvent extends PostEvent {}
class PostContinueEvent extends PostEvent {}
class PostLoadingEvent extends PostEvent {}

class PostGetEvent extends PostEvent {
  final int start;
  final int limit;

  PostGetEvent({required this.start, required this.limit});

  @override
  List<Object?> get props => [start, limit];
  
}