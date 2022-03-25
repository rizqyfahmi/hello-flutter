import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Image Gradient"),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
              },
              blendMode: BlendMode.dstIn,
              child: const Image(
                image: NetworkImage("https://img.freepik.com/free-vector/beautiful-gradient-spring-landscape_23-2148448598.jpg?size=626&ext=jpg&ga=GA1.2.625627942.1648039534"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}