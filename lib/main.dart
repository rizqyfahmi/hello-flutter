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
  bool isFaceDetected = false;
  CameraController? cameraController;
  FaceDetector? faceDetector;
  File? imageResult;
  List<Face> faces = [];
  
  late AnimationController bottomSheetAnimationController;
  late Animation bottomSheetAnimation;
  
  @override
  void initState() {
    bottomSheetAnimationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    bottomSheetAnimation = Tween<double>(begin: 1, end: 0).animate(bottomSheetAnimationController)
    ..addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isCameraInitialized = false;
          isFaceDetected = false;
          imageResult = null;
          faces = [];
          initFaceDetector();
          initCamera();
        });
      }
    });

    initFaceDetector();
    initCamera();
    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    faceDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized) return const Center(child: CircularProgressIndicator());

    log("AspectRatio: ${MediaQuery.of(context).size} ${MediaQuery.of(context).size.width}");
    
    final scale = 1 / (cameraController!.value.aspectRatio * MediaQuery.of(context).size.aspectRatio);

    return Scaffold(
      body: Row(children: [
        Expanded(
          child: Stack(
            children: [
              Center(
                child: Transform.scale(
                  scale: scale,
                  child: CameraPreview(cameraController!),
                )
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
                        faces: faces,
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

  void initFaceDetector() {
    faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
      enableClassification: true,
      enableTracking: true,
      enableContours: true
    ));
  }

  void initCamera() async {
    cameraController?.dispose();
    // Activate camera back
    CameraDescription camera = await CameraUtils.getCamera(CameraLensDirection.front);
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

      startImageStream();

      setState(() {
        imageResult = null;
        cameraController?.setFlashMode(FlashMode.off);
      });
    } catch (e) {
      log("Init cameraController: ${e.toString()}");
    }
  }

  void onScanned(Face face) {
    if (isFaceDetected) return;

    print("Hello ${face.smilingProbability}");

    isFaceDetected = true;

    onTakePicture();
  }

  void onTakePicture() async {
    log("onTakePicture: $isCameraInitialized");

    if (!isCameraInitialized) return;

    await cameraController?.pausePreview();

    bottomSheetAnimationController.forward();
  }

  void startImageStream() async {
    if (cameraController == null) return;

    await cameraController?.startImageStream((image) async {
        
     if (isFaceDetected || (cameraController == null)) {
        return;
      }

      isFaceDetected = true;

      final InputImageRotation imageRotation = InputImageRotationValue.fromRawValue(cameraController!.description.sensorOrientation) ?? InputImageRotation.rotation0deg;

      List<Face> tempFaces = await CameraUtils.detectFace(
        image: image,
        imageRotation: imageRotation,
        faceDetector: faceDetector!
      );

      setState(() {
        faces = tempFaces;
      });

      isFaceDetected = false;

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
