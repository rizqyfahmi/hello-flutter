import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FramePainter extends CustomPainter {

  final List<Barcode> barcodes;
  
  FramePainter({
    required this.barcodes, 
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black54;

    final holeRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.5), 
      width: size.width * 0.8, 
      height: size.width * 0.8
    );

    final Paint detectorPaint = Paint();
    detectorPaint.style = PaintingStyle.fill;
    detectorPaint.strokeWidth = 2;

    final List<Rect> filteredBarcodeRect = [];
    
    // Filter barcode
    for (Barcode barcode in barcodes) {
      
      final Rect barcodeRect = _scaleRect(barcode, size);

      // Prevent a barcode that the part of QR code still inside the frame
      if (
        barcodeRect.left < holeRect.left ||
        barcodeRect.top < holeRect.top ||
        barcodeRect.right > holeRect.right ||
        barcodeRect.bottom > holeRect.bottom
      ) {
        continue;
      }

      // Prevent a barcode that the QR code is out of range of the frame
      if (
        barcodeRect.left > holeRect.right ||
        barcodeRect.top > holeRect.bottom ||  
        barcodeRect.right < holeRect.left ||
        barcodeRect.bottom < holeRect.top
      ) {
        continue;
      }

      filteredBarcodeRect.add(barcodeRect);
    }

    for (Rect rect in filteredBarcodeRect) {
      detectorPaint.color = Colors.green;

      if (filteredBarcodeRect.length > 1) {
        detectorPaint.color = Colors.red;
      }

      // Draw barcode rectangle to the screen
      canvas.drawRect(rect, detectorPaint);
    }

    // Create masked frame overlay
    final Path path = Path.combine(
      PathOperation.difference, 
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height))..close(), 
      Path()..addRRect(
        RRect.fromRectAndRadius(
          holeRect,
          const Radius.circular(16)
        )
      )..close()
    );

    // Draw masked frame overlay to the screen
    canvas.drawPath(path, paint);
  } 

  Rect _scaleRect(Barcode barcode, Size size) {
    final double scaleX = size.width / 720; // Based on the resolution that we set on camera initialization (ResolutionPreset.high).
    final double scaleY = size.height / 1280; // Based on the resolution that we set on camera initialization (ResolutionPreset.high).

    return Rect.fromLTRB(
      (barcode.boundingBox?.left ?? 0) * scaleX,
      (barcode.boundingBox?.top ?? 0) * scaleY,
      (barcode.boundingBox?.right ?? 0) * scaleX,
      (barcode.boundingBox?.bottom ?? 0) * scaleY
    );
    
  }

  @override
  bool shouldRepaint(FramePainter oldDelegate) => oldDelegate.barcodes != barcodes;
  
}