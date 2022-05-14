import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hello_flutter/camera_utils.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
  } catch (e) {
    log("Main: ${e.toString()}");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isCameraInitialized = false;
  bool isBarcodeDetected = false;
  CameraController? cameraController;
  File? imageResult;
  late BarcodeScanner barcodeScanner;

  @override
  void initState() {
    initBarcodeScanner();
    initCamera();
    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized) return const Center(child: CircularProgressIndicator());


    log("AspectRatio: ${MediaQuery.of(context).size} ${MediaQuery.of(context).size.width}");
    return Scaffold(
      body: Row(children: [
        Expanded(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        log("Constraints Camera: ${constraints.biggest}");
                        return AspectRatio(
                          aspectRatio: constraints.biggest.aspectRatio,
                          child: CameraPreview(cameraController!),
                        );
                      }
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                    decoration: ShapeDecoration(
                      shape: _ScannerOverlayShape(
                        borderColor: Theme.of(context).primaryColor,
                        borderWidth: 3.0,
                      ),
                    ),
                  )
                  )
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        log("Constraints: ${constraints.biggest}");
                        return AspectRatio(
                          aspectRatio: constraints.biggest.aspectRatio,
                          child: onRenderResult(constraints.biggest.height, constraints.biggest.width),
                        );
                      }
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.transparent,
                    child:
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      IconButton(
                        icon: onRenderControlIcon(),
                        onPressed: () {
                          if ((imageResult == null) || (imageResult?.path == "")) {
                            return onTakePicture();
                          }

                          setState(() {
                            isCameraInitialized = false;
                            imageResult = null;
                            initCamera();
                          });
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void initBarcodeScanner() {
    final List<BarcodeFormat> formats = [
      BarcodeFormat.all,
      BarcodeFormat.qrCode
    ];

    // barcodeScanner = BarcodeScanner(formats: formats);
    barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  }

  initCamera() async {
    cameraController?.dispose();
    // Activate camera back
    CameraDescription camera = await CameraUtils.getCamera(CameraLensDirection.back);
    // Init camera controller
    cameraController = CameraController(
      camera, 
      ResolutionPreset.high,
      enableAudio: false
    );  

    try {
      await cameraController?.initialize().whenComplete(() {
        setState(() {
          isCameraInitialized = true;
        });
      });

      await cameraController?.startImageStream((image) async {
        
        if (isBarcodeDetected || (cameraController == null)) {
          return;
        }

        isBarcodeDetected = true;

        final InputImageRotation imageRotation = InputImageRotationValue.fromRawValue(cameraController!.description.sensorOrientation) ?? InputImageRotation.rotation0deg;

        List<Barcode> barcodes = await CameraUtils.detectBarcode(
          image: image,
          imageRotation: imageRotation,
          barcodeScanner: barcodeScanner
        );

        if (barcodes.isEmpty) {
          isBarcodeDetected = false;
          return;
        }

        for (Barcode barcode in barcodes) {
          final BarcodeType type = barcode.type;
          final String? displayValue = barcode.displayValue;
          final String? rawValue = barcode.rawValue;

          print("Type: $type");
          print("Raw Value: $rawValue");
          print("Display Value: $displayValue");
        }

        isBarcodeDetected = false;
      });

      setState(() {
        imageResult = null;
        cameraController?.setFlashMode(FlashMode.off);
      });
    } catch (e) {
      log("Init cameraController: ${e.toString()}");
    }
  }

  void onTakePicture() async {
    log("onTakePicture: $isCameraInitialized");

    if (!isCameraInitialized) return;
    
    XFile? imageFile = await cameraController?.takePicture();
    
    setState(() {
      imageResult = File(imageFile!.path);
    });
  }

  Widget onRenderResult(double height, double width) {
    log("onRenderResult: $imageResult");

    if ((imageResult == null) || (imageResult?.path == "")) return Container();

    return Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.file(
              imageResult!,
              height: height,
              width: width,
              fit: BoxFit.fill,
            )
          ],
        ));
  }

  Widget onRenderControlIcon() {
    if ((imageResult == null) || (imageResult?.path == "")) return const Icon(Icons.camera, color: Colors.white,);

    return const Icon(Icons.restart_alt_rounded, color: Colors.white);
  }
}

class _ScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;

  const _ScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderWidth = 1.0,
    this.overlayColor = const Color(0x88000000),
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(0.0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    print("Hello: ${rect.toString()}");

    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return _getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    const lineSize = 30;

    final width = rect.width;
    final borderWidthSize = width * 10 / 100;
    final height = rect.height;
    final borderHeightSize = height - (width - borderWidthSize);
    final borderSize = Size(borderWidthSize / 2, borderHeightSize / 2);

    var paint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    canvas
      ..drawRect(
        Rect.fromLTRB(
            rect.left, rect.top, rect.right, borderSize.height + rect.top),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.bottom - borderSize.height, rect.right,
            rect.bottom),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.top + borderSize.height,
            rect.left + borderSize.width, rect.bottom - borderSize.height),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(
            rect.right - borderSize.width,
            rect.top + borderSize.height,
            rect.right,
            rect.bottom - borderSize.height),
        paint,
      );

    // Borders
    paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final borderOffset = borderWidth / 2;
    final realReact = Rect.fromLTRB(
        borderSize.width + borderOffset,
        borderSize.height + borderOffset + rect.top,
        width - borderSize.width - borderOffset,
        height - borderSize.height - borderOffset + rect.top);

    //Draw top right corner
    canvas
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right - lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.top)],
        paint,
      )

      //Draw top left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left + lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.top)],
        paint,
      )

      //Draw bottom right corner
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right - lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.bottom)],
        paint,
      )

      //Draw bottom left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left + lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.bottom)],
        paint,
      );
  }

  @override
  ShapeBorder scale(double t) {
    return _ScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
