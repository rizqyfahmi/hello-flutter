import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Shimmer Demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  const SizedBox(
                    width: 200,
                    height: 300,
                    child: Image(
                      image: NetworkImage("https://s1.bukalapak.com/img/68286857232/large/Poster_Film___Avengers_Endgame___Marvel_Studios___Movie_Post.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Shimmer(
                    direction: ShimmerDirection.ltr,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: const [0.4, 0.5, 0.6],
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.grey.withOpacity(0.5),
                        Colors.white.withOpacity(0),
                      ]
                    ),
                    child: Container(
                      width: 200,
                      height: 300,
                      color: Colors.red
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}