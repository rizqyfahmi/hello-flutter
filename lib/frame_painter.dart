import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:collection/collection.dart';

class FramePainter extends CustomPainter {

  final List<Face> faces;
  final ValueSetter<Face> onScanned;
  
  FramePainter({
    required this.faces, 
    required this.onScanned
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black54;

    final holeRect = Rect.fromCircle(
      center: Offset(size.width * 0.5, size.height * 0.5), 
      radius: (size.width * 0.5) - 15
    );

    // Create masked frame overlay
    final Path path = Path.combine(
      PathOperation.difference, 
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height))..close(), 
      Path()..addOval(holeRect)..close()
    );

    // Draw masked frame overlay to the screen
    canvas.drawPath(path, paint);

    /* ------------------------ Start | Detector ------------------------ */
    final Paint detectorPaint = Paint();
    detectorPaint.style = PaintingStyle.stroke;
    detectorPaint.strokeWidth = 5;

    final Path detectorCircle = Path.from(
      Path()..addOval(holeRect)
    );
    

    for (Face face in faces) {
      print("Hello ${face.smilingProbability}");

      final Rect rect = _scaleRect(face.boundingBox, size);
      detectorPaint.color = Colors.green;
      
      // Prevent a barcode that the part of QR code still inside the frame
      if (
        rect.left < holeRect.left ||
        rect.top < holeRect.top ||
        rect.right > holeRect.right ||
        rect.bottom > holeRect.bottom
      ) {
        detectorPaint.color = Colors.red;
        canvas.drawPath(detectorCircle, detectorPaint);
        // canvas.drawRect(rect, detectorPaint);
        continue;
      }

      // canvas.drawRect(rect, detectorPaint);
      canvas.drawPath(detectorCircle, detectorPaint);

      if ((face.smilingProbability ?? 0) > 0.9) {
        onScanned(face);
        break;  
      }
    }

    /* ------------------------ End | Detector ------------------------ */

  } 

  Rect _scaleRect(Rect box, Size size) {
    final double scaleX = size.width / 720; // Based on the resolution that we set on camera initialization (ResolutionPreset.high).
    final double scaleY = size.height / 1280; // Based on the resolution that we set on camera initialization (ResolutionPreset.high).

    return Rect.fromLTRB(
      (box.left) * scaleX,
      (box.top) * scaleY,
      (box.right) * scaleX,
      (box.bottom) * scaleY
    );
    
  }

  @override
  bool shouldRepaint(FramePainter oldDelegate) => oldDelegate.faces != faces;
  
}

class Content extends Equatable{
  final String key;
  String? value;
  Rect? keyRect;

  Content({
    required this.key,
    this.value,
    this.keyRect
  });

  @override
  List<Object?> get props => [key];
}