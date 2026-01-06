import 'package:flutter/material.dart';

/// Reusable dashed line painter component
/// Used in: point_to_point_view, schedule_ride_view, ride_selection_view, ride_booked_view, ride_history_view
class DashedLinePainter extends CustomPainter {
  const DashedLinePainter({
    this.color = Colors.grey,
    this.strokeWidth = 1,
    this.dashHeight = 4,
    this.dashSpace = 4,
    this.isVertical = true,
  });

  final Color color;
  final double strokeWidth;
  final double dashHeight;
  final double dashSpace;
  final bool isVertical;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    if (isVertical) {
      double startY = 0;
      while (startY < size.height) {
        canvas.drawLine(
          Offset(0, startY),
          Offset(0, startY + dashHeight),
          paint,
        );
        startY += dashHeight + dashSpace;
      }
    } else {
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, 0),
          Offset(startX + dashHeight, 0),
          paint,
        );
        startX += dashHeight + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Vertical dashed line painter (commonly used in route displays)
class DashedLineVerticalPainter extends CustomPainter {
  const DashedLineVerticalPainter({
    this.color = Colors.grey,
    this.strokeWidth = 2,
    this.dashHeight = 5,
    this.dashSpace = 3,
  });

  final Color color;
  final double strokeWidth;
  final double dashHeight;
  final double dashSpace;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

