import 'package:apex/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackButtonHeader extends StatelessWidget {
  const BackButtonHeader({
    Key? key,
    required this.title,
    this.onBack,
    this.showBackButton = true,
    this.backgroundColor,
    this.buttonBg,
    this.titleStyle,
    this.padding,
  }) : super(key: key);

  final String title;
  final VoidCallback? onBack;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? buttonBg;
  final TextStyle? titleStyle;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final Color defaultButtonBg = buttonBg ?? R.theme.cardBg;
    final Color defaultBg = backgroundColor ?? Colors.transparent;

    return Container(
      color: defaultBg,
      padding: padding ?? const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showBackButton)
            InkWell(
              onTap: onBack ?? () => Get.back(),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: defaultButtonBg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            )
          else
            44.sbw,
          Text(
            title,
            style:
                titleStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Urbanist',
                ),
          ),
          44.sbw,
        ],
      ),
    );
  }
}
