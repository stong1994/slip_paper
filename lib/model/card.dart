import 'shape.dart';

class Card {
  String id;
  String content;
  int type;
  double posX;
  double posY;
  Shape shape;
  int createDt;
  int updateDt;

  Card({
    this.id = "",
    this.content = "",
    this.type = 0,
    this.posX = 0,
    this.posY = 0,
    this.shape = Shape.circle,
    this.createDt = 0,
    this.updateDt = 0,
  });

  Card copyWith({
    String? id,
    String? content,
    int? type,
    double? posX,
    double? posY,
    Shape? shape,
    int? createDt,
    int? updateDt,
  }) {
    return Card(
      id: id ?? this.id,
      content: content ?? this.content,
      type: type ?? this.type,
      posX: posX ?? this.posX,
      posY: posY ?? this.posY,
      shape: shape ?? this.shape,
      createDt: createDt ?? this.createDt,
      updateDt: updateDt ?? this.updateDt,
    );
  }

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'],
      content: json['content'],
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
        'type': type,
        'create_dt': createDt,
        'update_dt': updateDt,
        'pos_x': posX,
        'pos_y': posY,
        'shape': shape.index,
      };
}
