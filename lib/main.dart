import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
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
  CameraController? cameraController;
  File? imageResult;
  Future<Directory?>? appDocumentsDirectory;

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
    cameraController = CameraController(
      camera, 
      ResolutionPreset.max, 
      imageFormatGroup: ImageFormatGroup.jpeg
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

  void onTakePicture() async {
    log("onTakePicture: $isCameraInitialized");

    if (!isCameraInitialized) return;
    
    XFile? imageFile = await cameraController?.takePicture();

    bool? isSuccess = await GallerySaver.saveImage(imageFile!.path, albumName: "Hello Flutter");

    log("Result: ${(isSuccess ?? false)}");
    
    setState(() {
      imageResult = File(imageFile.path);
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
