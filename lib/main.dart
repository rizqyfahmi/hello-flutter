
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.red
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   appBarTheme: const AppBarTheme(
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarColor: Colors.red
      //     )
      //   )
      // ),
      home: MainPage()
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController greenScrollController = ScrollController();
  ScrollController yellowScrollController = ScrollController();
  ScrollController redScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    yellowScrollController.addListener(() {
      print("Hello Yellow: ${yellowScrollController.offset}");
      greenScrollController.jumpTo(yellowScrollController.offset * 0.25); // greenScrollController more slower than yellowScrollController
    });

    redScrollController.addListener(() {
      print("Hello Red: ${redScrollController.offset}");
      yellowScrollController.jumpTo(redScrollController.offset * 0.65); // yellowScrollController more slower than redScrollController
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.red,
            height: size.height,
            width: size.width
          ),
          SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: greenScrollController,
                  child: Container(
                    padding: const EdgeInsets.only(top: 18),
                    width: size.width,
                    height: size.height + 100,
                    color: Colors.green,
                    child: const Text(
                      "Green",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  controller: yellowScrollController,
                  child: Container(
                    margin: const EdgeInsets.only(top: 100),
                    width: size.width,
                    height: size.height + 100,
                    color: Colors.yellow,
                    child: const Text(
                      "Yellow",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  controller: redScrollController,
                  child: Container(
                    margin: const EdgeInsets.only(top: 150),
                    width: size.width,
                    height: size.height + 150,
                    color: Colors.red,
                    child: const Text(
                      "Red",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircularChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    
    double radius = min((size.width - 32) / 2, (size.height - 32) / 2);
    /*
      The angle is calculated by π, 2π = 360 degrees. The starting angle is clockwise from three o'clock. 
      But we need to start clockwise from 0 o'clock, that is, we need 180 degrees counterclockwise = -π/2 = -180/2 (flutter uses pi to represent π)
    */
    double startAngle = -pi / 2;
    double endAngle = (2 * pi) * 0.6; // 2 * π = full circle, 0.6 = 60%

    Rect circle = Rect.fromCircle(center: center, radius: radius);

    var paint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, paint);

    paint.color = Colors.green;
    canvas.drawArc(circle, startAngle, endAngle, false, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}