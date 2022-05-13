import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class CameraUtils {
  static Future<CameraDescription> getCamera(
      CameraLensDirection cameraDirection) async {
    return availableCameras().then((List<CameraDescription> cameraList) {
      return cameraList
          .firstWhere((camera) => camera.lensDirection == cameraDirection);
    });
  }

  static Future<List<Barcode>> detectBarcode(
      {required CameraImage image,
      required InputImageRotation imageRotation,
      required BarcodeScanner barcodeScanner}) async {
    
    // final InputImage inputImage = getInputImage(image, camera);
    // print("Hello: ${inputImage.toString()}");
    
    
    

    // return barcodeScanner.processImage(inputImage);


    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final inputImageFormat = InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21;
    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    return barcodeScanner.processImage(
      InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData),
    );
  }

  static InputImage getInputImage(CameraImage image, CameraController camera) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }

    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final InputImageRotation imageRotation = InputImageRotationValue.fromRawValue(camera.description.sensorOrientation) ?? InputImageRotation.rotation0deg;
    final InputImageFormat inputImageFormat = InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21;

    final planeData = image.planes.map((Plane plane) {
      return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width);
    }).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    return InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
  }
}
