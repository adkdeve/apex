import 'package:apex/app/core/core.dart';
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlight;
  final Color? labelColor;
  final Color? valueColor;

  const InfoRow({
    Key? key,
    required this.label,
    required this.value,
    this.isHighlight = false,
    this.labelColor,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: labelColor ?? R.theme.driverGreyText,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color:
                  valueColor ??
                  (isHighlight ? R.theme.goldAccent : Colors.white),
              fontSize: 14,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
