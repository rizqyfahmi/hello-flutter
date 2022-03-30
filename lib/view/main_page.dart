import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/model/post.dart';
import 'package:hello_flutter/view_model/post/post_bloc.dart';
import 'package:hello_flutter/view_model/post/post_state.dart';
import 'package:hello_flutter/widgets/post_card.dart';

import '../view_model/post/post_event.dart';

class MainPage extends StatefulWidget {

  const MainPage({ Key? key }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController controller = ScrollController();
  PostBloc? _bloc;

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;
    
    if (currentScroll == maxScroll) {
      _bloc?.add(PostLoadingEvent());
      _bloc?.add(PostContinueEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<PostBloc>(context);
    controller.addListener(onScroll);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Infinity Scroll Demo"),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 5, bottom: 5, left: 10, right: 10
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  developer.log(state.toString());
                  if (state is PostUninitializedState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
            
                  PostLoadedState postLoadedState = state as PostLoadedState;
                  return ListView.builder(
                    controller: controller,
                    itemCount: (postLoadedState.hasReachedMax) ? postLoadedState.posts.length : postLoadedState.posts.length + 1,
                    itemBuilder: (context, index) {
                      if (index < postLoadedState.posts.length) {
                        Post post = postLoadedState.posts[index];
                        return Container(
                          margin: const EdgeInsets.only(
                            top: 5, bottom: 5
                          ),
                          child: PostCard(
                            id: post.id,
                            title: post.title,
                            body: post.body,
                          ),
                        );
                      }
            
                      if (state is PostLoadingState) {
                        return Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );  
                      }
                      
                      return Container();
                    }
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}