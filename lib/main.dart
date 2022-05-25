
import 'dart:math';
import 'dart:ui';
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

  GlobalKey childKey = GlobalKey();
  GlobalKey parentKey = GlobalKey();

  RenderBox? box;

  void afterLayout() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? childBox = childKey.currentContext?.findRenderObject() as RenderBox;
      
      if (childBox == null) return;

      setState(() {
        box = childBox;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    
    afterLayout();
    
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
    final padding = MediaQuery.of(context).padding;
    
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height + 150,
              color: Colors.red,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "Hello one time",
                      key: childKey,
                      style: const TextStyle(
                        fontSize: 28
                      ),
                    ),
                  )
                ]
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: CustomPaint(
                    painter: ShowcasePainter(renderBox: box, top: padding.top),
                    child: Container(),
                  ),
                ),
              ],
            )
          ],
        ),
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

class ShowcasePainter extends CustomPainter {
  final RenderBox? renderBox;
  final double top;

  ShowcasePainter({
    required this.renderBox,
    required this.top
  });

  @override
  void paint(Canvas canvas, Size size) {

    if (renderBox == null) return;

    final Size sizeBox = renderBox!.size;
    final Offset offsetBox = renderBox!.localToGlobal(Offset.zero);

    print("Hello: $offsetBox $sizeBox ${top}");

    final Path path = Path.combine(
      PathOperation.difference, 
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height))..close(), 
      Path()..addRRect(
        RRect.fromRectAndRadius(
          // Rect.fromLTRB(offsetBox.dx, offsetBox.dy - sizeBox.height, offsetBox.dx + sizeBox.width, offsetBox.dy), 
          Rect.fromLTWH(offsetBox.dx, offsetBox.dy - top, sizeBox.width, sizeBox.height), 
          const Radius.circular(0)
        )
      )
    )..close();

    final Paint paint = Paint();
    paint.color = Colors.black54;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}