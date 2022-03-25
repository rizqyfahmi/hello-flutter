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
          title: const Text("ClipPath Image"),
        ),
        body: Center(
          child: ClipPath(
            clipper: MyClipper(),
            child: Container(
              margin: const EdgeInsets.all(20),
              child: const Image(
                image: NetworkImage("https://u7.uidownload.com/vector/994/571/vector-northern-lights-landscape-vector-svg-eps.jpg"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, size.height * (1 / 4), size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
  
}