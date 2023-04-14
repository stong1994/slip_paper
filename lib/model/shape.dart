enum Shape { square, circle, diamond, hexagon, octagon }

enum PaperType { toBeDigested, program, toBeEvaluated, tricky, garbage }

extension PaperTypeExtension on PaperType {
  String get name {
    switch (this) {
      case PaperType.toBeDigested:
        return "待消化";
      case PaperType.program:
        return "程序";
      case PaperType.toBeEvaluated:
        return "待评估";
      case PaperType.tricky:
        return "棘手";
      case PaperType.garbage:
        return "垃圾";
    }
  }
}
