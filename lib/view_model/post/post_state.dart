import 'package:equatable/equatable.dart';
import 'package:hello_flutter/model/post.dart';

class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostUninitializedState extends PostState {}

class PostLoadedState extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  PostLoadedState({required this.posts, this.hasReachedMax = false});

  @override
  List<Object?> get props => [posts.length, hasReachedMax];
}

class PostLoadingState extends PostLoadedState {
  PostLoadingState({required List<Post> posts}) : super(posts: posts);
}
