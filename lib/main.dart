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

class _MainPageState extends State<MainPage> with TickerProviderStateMixin{
  bool isCameraInitialized = false;
  CameraController? cameraController;
  TextRecognizer? textRecognizer;
  File? imageResult;
  List<TextBlock> textBlocks = [];
  
  TextBlock? textBlock;
  late AnimationController bottomSheetAnimationController;
  late Animation bottomSheetAnimation;
  
  @override
  void initState() {
    final logicalPixel = window.physicalSize / window.devicePixelRatio;
    final logicalWidth = logicalPixel.width;
    final logicalHeight = logicalPixel.height;

    final frameSize = logicalWidth * 0.8;
    final frameStart = (logicalHeight / 2) - (frameSize / 2);
    final frameEnd = frameStart + frameSize;

    bottomSheetAnimationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    bottomSheetAnimation = Tween<double>(begin: 1, end: 0).animate(bottomSheetAnimationController)
    ..addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isCameraInitialized = false;
          imageResult = null;
          textBlock = null;
          textBlocks = [];
          initTextRecognizer();
          initCamera();
        });
      }
    });

    initTextRecognizer();
    initCamera();
    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    textRecognizer?.close();
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
                        child: onRenderResult(constraints.biggest.height, constraints.biggest.width),
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
                    child: CustomPaint(
                      painter: FramePainter(
                        textBlocks: textBlocks,
                        onScanned: onScanned
                      ),
                      child: Container(),
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
                      ]
                    ),
                  ),
                ]
              ),
              AnimatedBuilder(
                animation: bottomSheetAnimation,
                builder: (context, child) => Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: FractionalTranslation(
                    translation: Offset(0, bottomSheetAnimation.value),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: TextButton(
                                onPressed: () {
                                  bottomSheetAnimationController.reverse();
                                }, 
                                child: const Center(
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                )
                              ),
                            )
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                            ),
                            child: IconButton(
                              onPressed: () {
                                bottomSheetAnimationController.reverse();
                              }, 
                              icon: const Icon(
                                Icons.close_rounded, 
                                color: Colors.white
                              )
                            ),
                          )
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)
                        )
                      ),
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  void initTextRecognizer() {
    textRecognizer = GoogleMlKit.vision.textRecognizer();
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

    try {
      await cameraController?.initialize().whenComplete(() {
        setState(() {
          isCameraInitialized = true;
        });
      });

      setState(() {
        imageResult = null;
        cameraController?.setFlashMode(FlashMode.off);
      });
    } catch (e) {
      log("Init cameraController: ${e.toString()}");
    }
  }

  void onScanned(List<Content> contents) {
    contents.forEach((element) {
      print("Hello ${element.key} ${element.value}");
    });
  }

  void onTakePicture() async {
    log("onTakePicture: $isCameraInitialized");

    if (!isCameraInitialized) return;

    XFile? image = await cameraController?.takePicture();

    imageResult = File(image!.path);
    
    final InputImageRotation imageRotation = InputImageRotationValue.fromRawValue(cameraController!.description.sensorOrientation) ?? InputImageRotation.rotation0deg;

    RecognizedText recognizedText = await CameraUtils.detectText(
      image: imageResult!,
      imageRotation: imageRotation,
      textRecognizer: textRecognizer!
    );

    print("Hello detector: ${recognizedText.blocks.length}");

    setState(() {
      textBlocks = recognizedText.blocks;
    });

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
