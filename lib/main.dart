import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/model/user.dart';
import 'package:hello_flutter/view/main_page.dart';
import 'package:hello_flutter/view_model/user/user_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<UserBloc>(
        create: (context) => UserBloc(UninitializedUser()),
        child: MainPage()
      ),
    );
  }
}