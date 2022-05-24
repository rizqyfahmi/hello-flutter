
import 'dart:convert';
import 'dart:math';

import 'package:encrypt/encrypt.dart' as encryption;
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage()
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Chart"),
      ),
      body: Stack(
        children: [
          Center(
            child: CustomPaint(
              painter: CircularChartPainter(),
              child: Container(),
            ),
          ),
          const Center(
            child: Text(
              "60%",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold
              ),
            ),
          )
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