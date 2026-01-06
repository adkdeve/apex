import 'package:apex/app/core/core.dart';
import 'package:flutter/material.dart';

class DriverDivider extends StatelessWidget {
  final double thickness;
  final Color? color;

  const DriverDivider({Key? key, this.thickness = 1, this.color})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? R.theme.driverBorderColor,
      thickness: thickness,
    );
  }
}
