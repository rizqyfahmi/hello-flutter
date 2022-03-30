import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/view/main_page.dart';
import 'package:hello_flutter/view_model/post/post_bloc.dart';
import 'package:hello_flutter/view_model/post/post_event.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc()..add(PostGetInitialEvent()),
      child: const MaterialApp(
        home: MainPage() 
      ),
    );
  }
}