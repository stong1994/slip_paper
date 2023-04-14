import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:slip_paper/page/paper.dart';
import 'package:uuid/uuid.dart';

import 'shape.dart';

class CardModel {
  String id;
  String content;
  PaperType type;
  double posX;
  double posY;
  Shape shape;
  Color color;
  int createDt;
  int updateDt;

  CardModel({
    this.id = "",
    this.content = "",
    this.color = Colors.white,
    this.type = PaperType.toBeDigested,
    this.posX = 0,
    this.posY = 0,
    this.shape = Shape.circle,
    this.createDt = 0,
    this.updateDt = 0,
  });

  CardModel random(PaperType type, double mid) {
    var options = Options(format: Format.hex, colorType: ColorType.green);
    var color = RandomColor.getColor(options);
    return CardModel(
      id: Uuid().v4(),
      color: stringToColor(color),
      type: type,
      posX: mid,
      posY: mid,
      shape: randomShape(),
      createDt: Timeline.now,
      updateDt: Timeline.now,
    );
  }

  CardModel copyWith({
    String? id,
    String? content,
    Color? color,
    PaperType? type,
    double? posX,
    double? posY,
    Shape? shape,
    int? createDt,
    int? updateDt,
  }) {
    return CardModel(
      id: id ?? this.id,
      content: content ?? this.content,
      color: color ?? this.color,
      type: type ?? this.type,
      posX: posX ?? this.posX,
      posY: posY ?? this.posY,
      shape: shape ?? this.shape,
      createDt: createDt ?? this.createDt,
      updateDt: updateDt ?? this.updateDt,
    );
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      content: json['content'],
      color: stringToColor(json['color']),
      type: PaperType.values[json['type']],
      posX: json['pos_x'],
      posY: json['pos_y'],
      shape: Shape.values[json['shape']],
      createDt: json['create_dt'],
      updateDt: json['update_dt'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'color': colorToString(color),
        'type': type.index,
        'create_dt': createDt,
        'update_dt': updateDt,
        'pos_x': posX,
        'pos_y': posY,
        'shape': shape.index,
      };
}

Color stringToColor(String colorString) {
  String valueString = colorString.replaceAll('#', '');
  if (valueString.length == 6) {
    valueString = 'FF' + valueString;
  }
  int value = int.parse(valueString, radix: 16);
  return Color(value);
}

String colorToString(Color color) {
  String hex = color.value.toRadixString(16).padLeft(8, '0');
  return '#$hex';
}
