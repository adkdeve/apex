import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DashedBorderPainter({
    this.strokeWidth = 1.5,
    this.color = Colors.grey,
    this.gap = 5.0,
    this.dashWidth = 5.0,
    this.dashSpace = 5.0,
    this.borderRadius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: const Offset(0, 0),
      b: Offset(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(a: Offset(x, 0), b: Offset(x, y), gap: gap);

    Path _bottomPath = getDashedPath(
      a: Offset(0, y),
      b: Offset(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: const Offset(0, 0),
      b: Offset(0, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    required Offset a,
    required Offset b,
    required double gap,
  }) {
    Path path = Path();
    path.moveTo(a.dx, a.dy);
    bool shouldDraw = true;
    Offset currentPoint = Offset(a.dx, a.dy);

    if (a.dy == b.dy) {
      // Horizontal
      while (currentPoint.dx < b.dx) {
        if (shouldDraw) {
          path.lineTo(currentPoint.dx + 5, currentPoint.dy);
        } else {
          path.moveTo(currentPoint.dx + 5, currentPoint.dy);
        }
        shouldDraw = !shouldDraw;
        currentPoint = Offset(currentPoint.dx + 5, currentPoint.dy);
      }
    } else {
      // Vertical
      while (currentPoint.dy < b.dy) {
        if (shouldDraw) {
          path.lineTo(currentPoint.dx, currentPoint.dy + 5);
        } else {
          path.moveTo(currentPoint.dx, currentPoint.dy + 5);
        }
        shouldDraw = !shouldDraw;
        currentPoint = Offset(currentPoint.dx, currentPoint.dy + 5);
      }
    }

    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
