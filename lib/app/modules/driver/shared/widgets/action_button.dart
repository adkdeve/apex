import 'package:flutter/material.dart';

/// Reusable action button for the dashboard
/// Supports both vertical (icon on top) and horizontal (icon on left) layouts
class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool horizontal;

  const ActionButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.color,
    this.iconColor,
    this.onTap,
    this.horizontal = true, // Default to horizontal layout
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: horizontal ? 60 : 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: horizontal ? _buildHorizontal() : _buildVertical(),
      ),
    );
  }

  Widget _buildHorizontal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor ?? Colors.white, size: 22),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildVertical() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor ?? Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
