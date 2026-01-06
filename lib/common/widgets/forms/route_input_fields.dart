import 'package:flutter/material.dart';
import 'package:apex/app/core/core.dart';

class RouteInputFields extends StatelessWidget {
  const RouteInputFields({
    Key? key,
    required this.pickupController,
    required this.dropoffController,
    this.pickupHint = "Choose pick up point",
    this.dropoffHint = "Choose your destination",
    this.pickupColor = Colors.redAccent,
    this.dropoffColor = const Color(0xFF27AE60),
    this.borderColor,
    this.onPickupTap,
    this.onDropoffTap,
    this.height = 120,
  }) : super(key: key);

  final TextEditingController pickupController;
  final TextEditingController dropoffController;
  final String pickupHint;
  final String dropoffHint;
  final Color pickupColor;
  final Color dropoffColor;
  final Color? borderColor;
  final VoidCallback? onPickupTap;
  final VoidCallback? onDropoffTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    final Color defaultBorderColor = borderColor ?? R.theme.secondary;

    return SizedBox(
      height: height,
      child: Stack(
        children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInputBox(
                hint: pickupHint,
                iconColor: pickupColor,
                controller: pickupController,
                borderColor: defaultBorderColor,
                onTap: onPickupTap,
              ),
              _buildInputBox(
                hint: dropoffHint,
                iconColor: dropoffColor,
                controller: dropoffController,
                borderColor: defaultBorderColor,
                isDestination: true,
                onTap: onDropoffTap,
              ),
            ],
          ),
          Positioned(
            left: 29,
            top: 35,
            bottom: 35,
            child: CustomPaint(
              painter: DashedLinePainter(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBox({
    required String hint,
    required Color iconColor,
    required TextEditingController controller,
    required Color borderColor,
    bool isDestination = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            isDestination
                ? Icon(Icons.location_on, color: iconColor, size: 24)
                : Container(
                    width: 24,
                    height: 16,
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                  ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: controller,
                enabled: onTap == null,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + 4), paint);
      startY += 6;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

