import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/model/user.dart';
import 'package:hello_flutter/view_model/user/user_bloc.dart';
import 'package:hello_flutter/view_model/user/user_event.dart';
import 'package:hello_flutter/widgets/profile_card.dart';

class MainPage extends StatelessWidget {
  final Random random = Random();
    
  MainPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserBloc bloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("MVVM Demo"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              final id = random.nextInt(10);
              bloc.add(UserGenerateRandom(id));
            }, 
            child: const Text("Generate random user")
          ),
          BlocBuilder<UserBloc, User>(
            builder: (context, state) {
              if (state is UninitializedUser) {
                return Container();
              }

              return ProfileCard(
                imageUrl: state.avatarUrl,
                name: state.name,
                email: state.email
              );
            }
          )
        ],
      ),
    );
  }
}