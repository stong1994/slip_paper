import 'shape.dart';

class CardModel {
  String id;
  String content;
  int type;
  double posX;
  double posY;
  Shape shape;
  String color;
  int createDt;
  int updateDt;

  CardModel({
    this.id = "",
    this.content = "",
    this.color = "",
    this.type = 0,
    this.posX = 0,
    this.posY = 0,
    this.shape = Shape.circle,
    this.createDt = 0,
    this.updateDt = 0,
  });

  CardModel copyWith({
    String? id,
    String? content,
    String? color,
    int? type,
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
      color: json['color'],
      type: json['type'],
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
        'color': color,
        'type': type,
        'create_dt': createDt,
        'update_dt': updateDt,
        'pos_x': posX,
        'pos_y': posY,
        'shape': shape.index,
      };
}
