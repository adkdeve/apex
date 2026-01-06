import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apex/app/core/core.dart';

/// Reusable success/thank you bottom sheet component
/// Used in: payment_method_view, rate_driver_view
class SuccessBottomSheet extends StatelessWidget {
  const SuccessBottomSheet({
    Key? key,
    required this.title,
    required this.message,
    this.buttonText = "Done",
    this.onButtonPressed,
    this.icon = Icons.verified,
    this.iconColor,
    this.backgroundColor,
    this.buttonColor,
    this.showHandle = false,
  }) : super(key: key);

  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? buttonColor;
  final bool showHandle;

  void show(BuildContext context) {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xFF0B0B0C),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showHandle)
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            if (showHandle) const SizedBox(height: 20),
            Icon(
              icon,
              size: 100,
              color: iconColor ?? R.theme.secondary,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: onButtonPressed ?? () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor ?? R.theme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // This widget is typically used via the show() method
    return const SizedBox.shrink();
  }
}

