import 'dart:developer';
import 'dart:io';

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
                    child: ClipPath(
                      child: Container(
                        color: Colors.black38 ,
                      ),
                      clipper: CustomCircular(),
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

class CustomCircular extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: Offset(size.width * 0.5, size.height * 0.5),
              width: size.width * 0.8,
              height: size.width * 0.8
            ),
            const Radius.circular(15)
          )
        )
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomCircular oldClipper) => false;
}
