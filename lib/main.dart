import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hello_flutter/camera_utils.dart';
import 'package:hello_flutter/frame_painter.dart';

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

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  bool isCameraInitialized = false;
  bool isBarcodeDetected = false;
  CameraController? cameraController;
  File? imageResult;
  late BarcodeScanner barcodeScanner;
  List<Barcode> barcodes = [];
  late AnimationController animationController;
  late Animation animation;
  
  @override
  void initState() {
    final logicalPixel = window.physicalSize / window.devicePixelRatio;
    final logicalWidth = logicalPixel.width;
    final logicalHeight = logicalPixel.height;

    final frameSize = logicalWidth * 0.8;
    final frameStart = (logicalHeight / 2) - (frameSize / 2);
    final frameEnd = frameStart + frameSize;

    animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    
    animation = Tween<double>(begin: frameStart, end: frameEnd).animate(animationController)
    ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    

    animationController.forward();
    
    initBarcodeScanner();
    initCamera();
    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    animationController.dispose();
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
                    child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, snapshot) {
                        return CustomPaint(
                          painter: FramePainter(
                            barcodes: barcodes,
                            scannerLine: animation.value
                          ),
                          child: Container(),
                        );
                      }
                    )
                  )
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void initBarcodeScanner() {
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

        List<Barcode> tempBarcodes = await CameraUtils.detectBarcode(
          image: image,
          imageRotation: imageRotation,
          barcodeScanner: barcodeScanner
        );

        setState(() {
          barcodes = tempBarcodes;
        });

        if (tempBarcodes.isEmpty) {
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

}
