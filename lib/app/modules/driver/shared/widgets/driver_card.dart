import 'package:apex/app/core/core.dart';
import 'package:flutter/material.dart';

class DriverCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? color;

  const DriverCard({
    Key? key,
    required this.child,
    this.padding,
    this.borderRadius = 20,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color ?? R.theme.cardBgVariant,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
