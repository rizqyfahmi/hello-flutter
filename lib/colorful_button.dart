import 'dart:math';

import 'package:flutter/material.dart';

class ColorfulButton extends StatefulWidget {
  final Color mainColor, secondColor;
  final IconData icon;

  const ColorfulButton({ Key? key, required this.mainColor, required this.secondColor, required this.icon }) : super(key: key);
  
  @override
  State<ColorfulButton> createState() => _ColorfulButtonState();
}

class _ColorfulButtonState extends State<ColorfulButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) => {
        setState(() {
          isPressed = !isPressed;
        })
      },
      onTapDown: (_) => {
        setState(() {
          isPressed = !isPressed;
        })
      },
      onTapCancel: () {
        setState(() {
          isPressed = !isPressed;
        });
      },
      child: Transform.rotate(
        angle: pi / 4,
        child: Material(
          borderRadius: BorderRadius.circular(15),
          elevation: isPressed ? 2 : 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                AnimatedContainer(
                  height: 50,
                  width: 50,
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: isPressed ? widget.secondColor : widget.mainColor,
                  ),
                  child: Transform.rotate(
                    angle: -pi / 4,
                    child: Icon(widget.icon, color: Colors.white)
                  )
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isPressed ? 0.0 : 0.5,
                  child: Transform.translate(
                    offset: const Offset(-30, -30), // X(left is negative, right is positif), Y(top is negative, bottom is positive)
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isPressed ? 0.0 : 0.5,
                  child: Transform.translate(
                    offset: const Offset(30, -30), // X(left is negative, right is positif), Y(top is negative, bottom is positive)
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isPressed ? 0.0 : 0.5,
                  child: Transform.translate(
                    offset: const Offset(30, 30), // X(left is negative, right is positif), Y(top is negative, bottom is positive)
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isPressed ? 0.0 : 0.5,
                  child: Transform.translate(
                    offset: const Offset(-30, 30), // X(left is negative, right is positif), Y(top is negative, bottom is positive)
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}