import 'dart:io';

import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class CameraUtils {
  
  static Future<CameraDescription> getCamera(CameraLensDirection cameraDirection) async {
    return availableCameras().then((List<CameraDescription> cameraList) {
      return cameraList.firstWhere((camera) => camera.lensDirection == cameraDirection);
    });
  }

  static Future<void> detectBarcode(File image, BarcodeScanner barcodeScanner) async {
    final InputImage inputImage = InputImage.fromFile(image);
    final List<Barcode> barcodes = await barcodeScanner.processImage(inputImage);

    print("Hello World: ${barcodes.toString()}");

    for (Barcode barcode in barcodes) {
      final BarcodeType type = barcode.type;
      final String? displayValue = barcode.displayValue;
      final String? rawValue = barcode.rawValue;

      print("Type: $type");
      print("Raw Value: $rawValue");
      print("Display Value: $displayValue");
    }

  } 

}