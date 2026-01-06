import 'package:apex/app/core/core.dart';
import 'package:apex/common/widgets/build_image.dart';
import 'package:flutter/material.dart';
import 'my_text.dart';

class SocialButton extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback? onTap;

  const SocialButton({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildImage(icon, width: 14, height: 14, context: context),
              6.sbw,
              Flexible(
                child: MyText(
                  text: text,
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
