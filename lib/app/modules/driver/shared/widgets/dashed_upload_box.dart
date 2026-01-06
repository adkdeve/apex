import 'package:apex/app/modules/driver/shared/utils/dashed_border_painter.dart';
import 'package:flutter/material.dart';

class DashedUploadBox extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData icon;
  final double height;

  const DashedUploadBox({
    Key? key,
    required this.onTap,
    this.text = 'Tap to upload',
    this.icon = Icons.upload_file,
    this.height = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        foregroundPainter: DashedBorderPainter(
          color: Colors.grey[700]!,
          strokeWidth: 1.5,
          gap: 5,
        ),
        child: Container(
          width: double.infinity,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.grey, size: 24),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
