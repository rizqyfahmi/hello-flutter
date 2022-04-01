import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/cubit/counter_cubit.dart';
import 'package:hello_flutter/cubit/counter_state.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cubit State Management"),
        ),
        body: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, state) {
            int value = 0;
            if (state is LoadedState) {
              value = state.amount;
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$value",
                    style: const TextStyle(fontSize: 50),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          /*
                            Cubit is a part of BLoC. The clear difference between Cubit and BLoC are the way it changes the state
                            - Cubit is method-driven state management. Cubit calls its method to change the state
                            - BLoC is event-driven state management. BLoC passes a BLoC event to change the state
                          */
                          context.read<CounterCubit>().increament();
                        },
                        child: const Icon(Icons.arrow_upward),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton(
                        onPressed: () {
                          /*
                            Cubit is a part of BLoC. The clear difference between Cubit and BLoC are the way it changes the state
                            - Cubit is method-driven state management. Cubit calls its method to change the state
                            - BLoC is event-driven state management. BLoC passes a BLoC event to change the state
                          */
                          context.read<CounterCubit>().decreament();
                        },
                        child: const Icon(Icons.arrow_downward),
                      )
                    ],
                  )
                ],
              ),
            );
          }, 
        ),
      ),
    );
  }
}