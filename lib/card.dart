import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slip_paper/db/card.dart';
import 'package:slip_paper/model/shape.dart';
import 'package:slip_paper/model/card.dart' as card_model;

class RandomShapeCard extends StatefulWidget {
  late card_model.Card card;

  RandomShapeCard(this.card);

  @override
  _RandomShapeCardState createState() => _RandomShapeCardState();
}

class _RandomShapeCardState extends State<RandomShapeCard> {
  late ShapeBorder shape;

  @override
  void initState() {
    super.initState();

    switch (widget.card.shape) {
      case Shape.square:
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        );
        break;
      case Shape.circle:
        shape = CircleBorder();
        break;
      case Shape.diamond:
        shape = CircleBorder();
        break;
      case Shape.hexagon:
        shape = StadiumBorder();
        break;
      case Shape.octagon:
        shape = StadiumBorder();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.card.posX,
      top: widget.card.posY,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            widget.card.posX += details.delta.dx;
            widget.card.posY += details.delta.dy;
            CardData().updateCard(widget.card);
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
                widget.card.content,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
