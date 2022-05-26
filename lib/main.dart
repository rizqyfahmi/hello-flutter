
import 'dart:math';
import 'package:flutter/material.dart';

void main() async {
  
  
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
  ScrollController contentScrollController = ScrollController();

  List<GlobalKey> globalKeys = [
    GlobalKey(), GlobalKey(), GlobalKey()
  ];

  GlobalKey contentKey = GlobalKey();
  
  RenderBox? box, contentBox;
  int currentIndex = 0;
  bool isFinished = false;

  void afterLayout() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChangeLayout();
    });
  }

  void onChangeLayout() {
    if (currentIndex == globalKeys.length) {
      setState(() {
        isFinished = !isFinished;
      });
      return;
    }

    final RenderBox? currentBox = globalKeys[currentIndex].currentContext?.findRenderObject() as RenderBox;
    final int nextIndex = currentIndex + 1;

    if (currentBox == null) return;

    setState(() {
      box = currentBox;
      currentIndex = nextIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    afterLayout();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      contentBox = contentKey.currentContext?.findRenderObject() as RenderBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final Offset? offset = box?.localToGlobal(Offset.zero);
    
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.red,
                )
              )
            ],
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: contentScrollController,
              child: Container(
                key: contentKey,
                width: size.width,
                color: Colors.red,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Hello one time",
                        key: globalKeys[0],
                        style: const TextStyle(
                          fontSize: 28
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Hello second time",
                        key: globalKeys[1],
                        style: const TextStyle(
                          fontSize: 28
                        ),
                      ),
                    ),
                    const SizedBox(height: 500),
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Hola",
                        key: globalKeys[2],
                        style: const TextStyle(
                          fontSize: 28
                        ),
                      ),
                    )
                  ]
                ),
              ),
            ),
          ),
          renderOverlay(padding: padding),
          renderButton(offset: offset, padding: padding)
        ],
      ),
    );
  }

  Widget renderOverlay({required EdgeInsets padding}) {
    if (isFinished) {
      return Container();
    }

    return Column(
      children: [
        Expanded(
          child: CustomPaint(
            painter: ShowcasePainter(renderBox: box, contentBox: contentBox, top: padding.top),
            child: Container(),
          ),
        ),
      ],
    );
  }

  Widget renderButton({required Offset? offset, required EdgeInsets padding}) {

    String text = "Selanjutnya";

    if (currentIndex >= globalKeys.length) { // currentIndex is gonna be 1 after call "afterLayout" at initState
      text = "Selesai";
    }

    if (isFinished) {
      return Container();
    }

    return Positioned(
      top: (offset?.dy ?? 0) + (box?.size.height ?? 0) + 16,
      left: offset?.dx ?? 0,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(16)
        ),
        child: TextButton(
          onPressed: () {
            onChangeLayout();
          },
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white
            )
          )
        ),
      )
    );
  }
}

class ShowcasePainter extends CustomPainter {
  final RenderBox? renderBox, contentBox;
  final double top;

  ShowcasePainter({
    required this.renderBox,
    required this.contentBox,
    required this.top
  });

  @override
  void paint(Canvas canvas, Size size) {

    if (renderBox == null) return;

    final Size sizeBox = renderBox!.size;
    final Offset offsetBox = renderBox!.localToGlobal(Offset.zero);
    
    final Size contentSize = contentBox!.size;

    print("Result: $size, $contentSize, $top");

    final Path path = Path.combine(
      PathOperation.difference, 
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height))..close(), 
      Path()..addRRect(
        RRect.fromRectAndRadius(
          // Rect.fromLTRB(offsetBox.dx, offsetBox.dy - sizeBox.height, offsetBox.dx + sizeBox.width, offsetBox.dy), 
          Rect.fromLTWH(offsetBox.dx, offsetBox.dy, sizeBox.width, sizeBox.height), 
          const Radius.circular(8)
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