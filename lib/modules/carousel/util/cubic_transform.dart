import 'dart:math' as math;
import 'package:flutter/material.dart';

class CubicTransform {
  final double perspectiveScale;
  final AlignmentGeometry rightPageAlignment;
  final AlignmentGeometry leftPageAlignment;
  final double rotationAngle;

  const CubicTransform({
    this.perspectiveScale = 0.0008,
    this.rightPageAlignment = Alignment.centerLeft,
    this.leftPageAlignment = Alignment.centerRight,
    double rotationAngle = 90,
  }) : rotationAngle = math.pi / 180 * rotationAngle;

  Widget transform(
    BuildContext context,
    Widget page,
    int index,
    int? currentPage,
    double pageDelta,
    int itemCount,
  ) {
    if (index == currentPage) {
      return Transform(
        alignment: leftPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(rotationAngle * pageDelta),
        child: page,
      );
    } else if (index == currentPage! + 1) {
      return Transform(
        alignment: rightPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(-rotationAngle * (1 - pageDelta)),
        child: page,
      );
    } else {
      return page;
    }
  }
}
