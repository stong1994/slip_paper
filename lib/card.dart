import 'dart:math';
import 'package:flutter/material.dart';

class RandomShapeCard extends StatefulWidget {
  @override
  _RandomShapeCardState createState() => _RandomShapeCardState();
}

class _RandomShapeCardState extends State<RandomShapeCard> {
  final Random random = Random();
  late ShapeBorder shape;

  double positionX = 0;
  double positionY = 0;

  @override
  void initState() {
    super.initState();
    int randomNumber =
        random.nextInt(3); // Generate a random number between 0 and 2
    switch (randomNumber) {
      case 0:
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        );
        break;
      case 1:
        shape = BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        );
        break;
      case 2:
        shape = StadiumBorder();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: positionX,
      top: positionY,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            positionX += details.delta.dx;
            positionY += details.delta.dy;
          });
        },
        child: Container(
          height: 100.0,
          width: 150.0,
          child: Card(
            shape: shape,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Random Shape Card',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
