import 'package:apex/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;

  const DriverBackButton({
    Key? key,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? R.theme.driverButtonBg,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 16,
          color: iconColor ?? Colors.white,
        ),
        onPressed: onPressed ?? () => Get.back(),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
