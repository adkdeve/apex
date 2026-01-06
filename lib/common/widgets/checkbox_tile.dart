import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app/core/resources/r.dart';
import '../../common/widgets/my_text.dart';

class CheckboxTile extends StatelessWidget {
  const CheckboxTile({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.size = 20.0,
    this.borderRadius = 4.0,
    this.checkAsset,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;
  final double size;
  final double borderRadius;
  final String? checkAsset;

  @override
  Widget build(BuildContext context) {
    final borderColor = value ? R.theme.primary : R.theme.inputBorder;

    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: value ? R.theme.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: borderColor),
            ),
            child: value
                ? (checkAsset != null
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset(checkAsset!, color: Colors.white),
                      )
                    : Icon(
                        Icons.check,
                        size: size - 6,
                        color: Colors.white,
                      ))
                : null,
          ),
          const SizedBox(width: 8),
          MyText(
            text: label,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
