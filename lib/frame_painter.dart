import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FramePainter extends CustomPainter {

  final List<TextBlock> textBlocks;
  final List<Color> scannerGradientColors;
  final double scannerLine;
  final ValueSetter<TextBlock> onBarcodeScanned;
  
  FramePainter({
    required this.textBlocks, 
    required this.scannerLine,
    required this.scannerGradientColors,
    required this.onBarcodeScanned
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black54;

    final holeRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.5), 
      width: size.width * 0.8, 
      height: (3/4) * (size.width * 0.8) //3:4 is the aspect ratio of ID Card
    );

    final Paint detectorPaint = Paint();
    detectorPaint.style = PaintingStyle.stroke;
    detectorPaint.strokeWidth = 5;

    final List<TextBlock> filteredTextBlocks = textBlocks.where((TextBlock textBlock) {

      final Rect rect = _scaleRect(textBlock.boundingBox, size);

      final bool isOutOfTheFrame = (
        rect.left > holeRect.right ||
        rect.top > holeRect.bottom ||  
        rect.right < holeRect.left ||
        rect.bottom < holeRect.top
      );

      final bool isNotPerfectlyInTheFrame = (
        rect.left < holeRect.left ||
        rect.top < holeRect.top ||
        rect.right > holeRect.right ||
        rect.bottom > holeRect.bottom
      );

      return (!isOutOfTheFrame) && (!isNotPerfectlyInTheFrame);
    }).toList();

    filteredTextBlocks.asMap().forEach((int index, TextBlock textBlock) {
      print("Hello ${textBlock.text}");
      
      detectorPaint.color = Colors.green;

      if (index % 2 == 0) {
        detectorPaint.color = Colors.yellow;
      }

      textBlock.lines.forEach((TextLine textLine) {
        textLine.elements.forEach((TextElement textElement) {
          final Rect barcodeRect = _scaleRect(textElement.boundingBox, size);

          canvas.drawRect(barcodeRect, detectorPaint);
        });
      });
    });

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
  bool shouldRepaint(FramePainter oldDelegate) => oldDelegate.textBlocks != textBlocks || oldDelegate.scannerGradientColors != scannerGradientColors;
  
}

class TextBlockAndRect {
  late final TextBlock textBlock;
  late final Rect rect;

  TextBlockAndRect({
    required this.textBlock,
    required this.rect
  });
}