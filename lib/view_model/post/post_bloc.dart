import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/model/post.dart';
import 'package:hello_flutter/view_model/post/post_event.dart';
import 'package:hello_flutter/view_model/post/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostUninitializedState()) {
    on<PostGetInitialEvent>((event, emit) async {
      add(PostGetEvent(start: 0, limit: 10));
    });
    on<PostLoadingEvent>((event, emit) async {
      List<Post> currentPosts = [];

      if (state is PostLoadedState) {
        currentPosts = (state as PostLoadedState).posts;
      }
      
      emit(PostLoadingState(posts: currentPosts));
      
    });
    on<PostContinueEvent>((event, emit) async {
      PostLoadedState currentState = state as PostLoadedState;
      try {
        List<Post> posts = await Post.getFromAPI(start: currentState.posts.length, limit: 10);
        emit(PostLoadedState(posts: [...currentState.posts, ...posts], hasReachedMax: posts.isEmpty)); // when post is empty, it means the post has reached max
      } catch (e) {
        developer.log(e.toString());

        if (state is PostUninitializedState) {
          emit(PostUninitializedState());
          return;
        }

        PostLoadedState currentState = state as PostLoadedState;
        emit(currentState);
      }
    });
    on<PostGetEvent>((event, emit) async {
      try {
        List<Post> posts = await Post.getFromAPI(start: event.start, limit: event.limit);
        emit(PostLoadedState(posts: posts, hasReachedMax: posts.isEmpty)); // when post is empty, it means the post has reached max
      } catch (e) {
        developer.log(e.toString());

        if (state is PostUninitializedState) {
          emit(PostUninitializedState());
          return;
        }

        PostLoadedState currentState = state as PostLoadedState;
        emit(currentState);
      }
    });
  } 
}