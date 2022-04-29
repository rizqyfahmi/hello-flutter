import 'package:camera/camera.dart';

class CameraUtils {
  
  static Future<CameraDescription> getCamera(CameraLensDirection cameraDirection) async {
    return availableCameras().then((List<CameraDescription> cameraList) {
      return cameraList.firstWhere((camera) => camera.lensDirection == cameraDirection);
    });
  }

  

}