import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double currentPage = 0;
  PageController controller = PageController(initialPage: 0, viewportFraction: 0.6);
  List<String> images = [
    "https://s1.bukalapak.com/img/68286857232/large/Poster_Film___Avengers_Endgame___Marvel_Studios___Movie_Post.jpg",
    "https://www.washingtonpost.com/graphics/2019/entertainment/oscar-nominees-movie-poster-design/img/black-panther-web.jpg",
    "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/5f51f696241415.5eb2d19f8b3e1.png"
  ];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PageView Demo"),
      ),
      body: Center(
        child: PageView.builder(
          controller: controller,
          itemCount: images.length,
          itemBuilder: (context, index) {
            double difference = min(1, (index - currentPage).abs());

            return Center(
              child: Container(
                height: 300 * (1 - (0.3 * difference)),
                width: 200 * (1 - (0.3 * difference)),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15)
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(
                  image: NetworkImage(images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
