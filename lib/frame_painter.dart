import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:collection/collection.dart';

class FramePainter extends CustomPainter {

  final List<TextBlock> textBlocks;
  final ValueSetter<List<Content>> onScanned;
  
  FramePainter({
    required this.textBlocks, 
    required this.onScanned
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black54;

    final holeRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.5), 
      width: size.width * 0.9, 
      height: (3/4) * (size.width * 0.9) //3:4 is the aspect ratio of ID Card
    );

    final Paint detectorPaint = Paint();
    detectorPaint.style = PaintingStyle.stroke;
    detectorPaint.strokeWidth = 2;

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

    List<Content> contents = [
      Content(key: "NIK"),
      Content(key: "Nama")
    ];

    // Set coordinate of field name
    for (TextBlock textBlock in filteredTextBlocks) {
      for (TextLine textLine in textBlock.lines) {
        Content? content = contents.firstWhereOrNull((element) => element.key == textLine.text);

        if (content == null) continue;

        content.keyRect = textLine.boundingBox;
        int index = contents.indexOf(content);
        contents[index] = content;
      }
    }
    
    // Get value of field name
    for (TextBlock textBlock in filteredTextBlocks) {
      for (TextLine textLine in textBlock.lines) {
        Content? content = contents.firstWhereOrNull((element) {

          double left = element.keyRect?.left ?? 0;
          double top = element.keyRect?.top ?? 0;
          double right = element.keyRect?.right ?? 0;
          double bottom = element.keyRect?.bottom ?? 0;

          double targetY = textLine.boundingBox.center.dy
          
          Rect targetRect = textLine.boundingBox;

          bool isExactlyTheSame = targetRect.left == left && targetRect.top == top && targetRect.right == right && targetRect.bottom == bottom;

          return (targetY >= top && targetY <= bottom) && (!isExactlyTheSame);

        });

        if (content == null) continue;

        content.value = textLine.text;
        int index = contents.indexOf(content);
        contents[index] = content;
      }
    }

    onScanned(contents);

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
  bool shouldRepaint(FramePainter oldDelegate) => oldDelegate.textBlocks != textBlocks;
  
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