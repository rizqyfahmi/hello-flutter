import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/camera_utils.dart';
import 'package:path_provider/path_provider.dart';

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
  CameraController? cameraController;
  XFile? imageResult;
  Future<Directory?>? appDocumentsDirectory;

  final GlobalKey containerCameraKey = GlobalKey();
  Size containerCameraSize = const Size(1.0, 1.0);

  @override
  void initState() {
    initCamera();
    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();
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
              // Expanded(
              //   key: containerCameraKey,
              //   child: LayoutBuilder(
              //     builder: (BuildContext context, BoxConstraints constraints) {
              //       final aspectRatio = constraints.biggest.aspectRatio;
              //       return Stack(
              //         children: [
              //           AspectRatio(
              //             aspectRatio: aspectRatio,
              //             child: CameraPreview(cameraController!),
              //           ),
              //           AspectRatio(
              //             aspectRatio: aspectRatio,
              //             child: onRenderResult(constraints.biggest.height),
              //           ),
              //         ],
              //       );
              //     }
              //   )
              // ),

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

  initCamera() async {
    cameraController?.dispose();
    // Activate camera back
    CameraDescription camera = await CameraUtils.getCamera(CameraLensDirection.back);
    // Init camera controller
    cameraController = CameraController(camera, ResolutionPreset.max, imageFormatGroup: ImageFormatGroup.jpeg);

    appDocumentsDirectory = getApplicationDocumentsDirectory();

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

  void onTakePicture() async {
    log("onTakePicture: $isCameraInitialized");

    if (!isCameraInitialized) return;

    imageResult = await cameraController?.takePicture();
    
    setState(() {});
  }

  Widget onRenderResult(double height, double width) {
    log("onRenderResult: $imageResult");

    if ((imageResult == null) || (imageResult?.path == "")) return Container();

    return Container(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.file(
              File(imageResult?.path ?? ""),
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
