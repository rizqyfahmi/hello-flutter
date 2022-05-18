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
      debugShowCheckedModeBanner: false,
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
  bool isDetectedBarcodeCaptured = false;
  CameraController? cameraController;
  File? imageResult;
  late BarcodeScanner barcodeScanner;
  List<Barcode> barcodes = [];
  List<Color> scannerGradientColors = [];
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
    });
    
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
                children: [
                  Expanded(
                    child: LayoutBuilder(builder: (context, constraints) {
                      log("Constraints: ${constraints.biggest}");
                      return AspectRatio(
                        aspectRatio: constraints.biggest.aspectRatio,
                        child: onRenderResult(constraints.biggest.height,
                            constraints.biggest.width),
                      );
                    }),
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
                            barcodes: !isDetectedBarcodeCaptured ? barcodes : [],
                            scannerLine: animation.value,
                            scannerGradientColors: scannerGradientColors,
                            onBarcodeScanned: onBarcodeScanned
                          ),
                          child: Container(),
                        );
                      }
                    )
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: onRenderControlIcon(),
                            onPressed: () {
                              if ((imageResult == null) ||
                                  (imageResult?.path == "")) {
                                return onTakePicture();
                              }

                              setState(() {
                                isCameraInitialized = false;
                                isDetectedBarcodeCaptured = false;
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
    barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  }

  void initCamera() async {
    cameraController?.dispose();
    // Activate camera back
    CameraDescription camera = await CameraUtils.getCamera(CameraLensDirection.back);
    // Init camera controller
    cameraController = CameraController(
      camera, 
      ResolutionPreset.high,
      enableAudio: false
    );

    scannerGradientColors = [Colors.transparent, Colors.transparent];
    animationController.reset();

    try {
      await cameraController?.initialize().whenComplete(() {
        setState(() {
          isCameraInitialized = true;
        });
      });

      startImageStream();

      setState(() {
        imageResult = null;
        cameraController?.setFlashMode(FlashMode.off);
      });
    } catch (e) {
      log("Init cameraController: ${e.toString()}");
    }
  }

  void startImageStream() async {
    if (cameraController == null) return;

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

      isBarcodeDetected = false;

    });
  }

  void onBarcodeScanned(Barcode barcode) async {
    if (isDetectedBarcodeCaptured) return;
    
    print("Hello Scanned: ${barcode.rawValue}");
    
    isDetectedBarcodeCaptured = true;

    onTakePicture();
    
  }

  void onTakePicture() async {
    log("onTakePicture: $isCameraInitialized");

    if (!isCameraInitialized) return;

    if (cameraController?.value.isStreamingImages ?? false) {
      await cameraController?.stopImageStream();
    }

    XFile? xImage = await cameraController?.takePicture();

    if (!(cameraController?.value.isPreviewPaused ?? false)) {
      await cameraController?.pausePreview();
    }

    setState(() {
      imageResult = File(xImage!.path);
       barcodes = [];
    });

    scannerGradientColors = [Colors.transparent, Colors.green];
    animationController.forward();
  }

  Widget onRenderResult(double height, double width) {
    log("onRenderResult: $imageResult");

    if ((imageResult == null) || (imageResult?.path == "")) return Container();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.file(
          File(imageResult?.path ?? ""),
          height: height,
          width: width,
          fit: BoxFit.fill,
        )
      ],
    );
  }

  Widget onRenderControlIcon() {
    if ((imageResult == null) || (imageResult?.path == "")) {
      return const Icon(
        Icons.camera,
        color: Colors.white,
      );
    }

    return const Icon(Icons.restart_alt_rounded, color: Colors.white);
  }

}
