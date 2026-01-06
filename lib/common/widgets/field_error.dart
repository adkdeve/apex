import 'package:flutter/material.dart';

class FieldError extends StatelessWidget {
  final String message;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double fontSize;
  final double iconSize;

  const FieldError({
    Key? key,
    required this.message,
    this.padding = const EdgeInsets.only(top: 6),
    this.color = Colors.red,
    this.fontSize = 12,
    this.iconSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: color,
            size: iconSize,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: color,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
