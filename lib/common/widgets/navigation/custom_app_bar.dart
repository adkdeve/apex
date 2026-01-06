import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apex/app/core/core.dart';

/// Reusable custom app bar with back button
/// Used in: payment_method_view, rate_driver_view, receipt_view, wallet_view
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBack,
    this.backgroundColor,
    this.titleColor,
    this.showBackButton = true,
    this.backButtonColor,
    this.centerTitle = true,
    this.elevation = 0,
    this.actions,
  }) : super(key: key);

  final String title;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool showBackButton;
  final Color? backButtonColor;
  final bool centerTitle;
  final double elevation;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final Color defaultBg = backgroundColor ?? R.theme.darkBackground;
    final Color defaultTitleColor = titleColor ?? Colors.white;
    final Color defaultBackButtonBg = backButtonColor ?? Colors.white24;

    return AppBar(
      backgroundColor: defaultBg,
      elevation: elevation,
      centerTitle: centerTitle,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: defaultTitleColor,
        ),
      ),
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: onBack ?? () => Get.back(),
                child: Container(
                  decoration: BoxDecoration(
                    color: defaultBackButtonBg,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

