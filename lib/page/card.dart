import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slip_paper/db/card.dart';
import 'package:slip_paper/model/shape.dart';
import 'package:slip_paper/model/card.dart';

class RandomShapeCard extends StatefulWidget {
  late CardModel card;

  RandomShapeCard(this.card);

  @override
  _RandomShapeCardState createState() => _RandomShapeCardState();
}

class _RandomShapeCardState extends State<RandomShapeCard> {
  late ShapeBorder shape;
  final _textEditingController = TextEditingController();

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
    _textEditingController.text = widget.card.content;
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
            color: widget.card.color,
            shape: shape,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _textEditingController,
                style: const TextStyle(fontSize: 16.0),
                maxLines: null,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '请输入...',
                ),
                onSubmitted: (value) {
                  widget.card.content = value;
                  CardData().updateCard(widget.card);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
