import 'dart:ui';

import 'package:flutter/material.dart';

class WidgetBgEmailPath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(
      size.width,
      size.height * 2.1,
    );
    path_0.lineTo(
      size.width,
      size.height * 0.4099499,
    );
    path_0.quadraticBezierTo(size.width * 0.7382750, size.height * 0.3050083,
        size.width * 0.1854125, size.height * 0.0862604);
    path_0.cubicTo(
        size.width * 0.0548625,
        size.height * 0.0474624,
        size.width * 0.0006000,
        size.height * 0.2103506,
        size.width * -0.0005125,
        size.height * 0.3057429);
    path_0.quadraticBezierTo(size.width * -0.0005125, size.height * 0.4797329,
        size.width * -0.0005125, size.height * 2.1);

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
