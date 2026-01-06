import 'package:flutter/material.dart';
import 'package:apex/app/core/core.dart';

/// Reusable fare breakdown row component
/// Used in: home_view, ride_selection_view, schedule_ride_view, receipt_view, ride_booked_view
class FareBreakdownRow extends StatelessWidget {
  const FareBreakdownRow({
    Key? key,
    required this.label,
    required this.value,
    this.labelColor,
    this.valueColor,
    this.isTotal = false,
    this.fontSize,
  }) : super(key: key);

  final String label;
  final String value;
  final Color? labelColor;
  final Color? valueColor;
  final bool isTotal;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final Color defaultLabelColor = labelColor ?? Colors.grey;
    final Color defaultValueColor = valueColor ?? R.theme.secondary;
    final double defaultFontSize = fontSize ?? (isTotal ? 16 : 14);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: defaultLabelColor,
              fontSize: defaultFontSize,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: defaultValueColor,
              fontSize: isTotal ? 18 : defaultFontSize,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist',
            ),
          ),
        ],
      ),
    );
  }
}

/// Fare breakdown section widget with multiple rows
class FareBreakdownSection extends StatelessWidget {
  const FareBreakdownSection({
    Key? key,
    required this.items,
    this.labelColor,
    this.valueColor,
    this.showDivider = true,
    this.dividerColor,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);

  final List<FareBreakdownItem> items;
  final Color? labelColor;
  final Color? valueColor;
  final bool showDivider;
  final Color? dividerColor;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      children.add(
        FareBreakdownRow(
          label: item.label,
          value: item.value,
          labelColor: item.labelColor ?? labelColor,
          valueColor: item.valueColor ?? valueColor,
          isTotal: item.isTotal,
        ),
      );

      if (showDivider && item.isTotal && i < items.length - 1) {
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              color: dividerColor ?? Colors.grey,
              thickness: 0.5,
            ),
          ),
        );
      }
    }

    Widget content = Column(children: children);

    if (backgroundColor != null || padding != null) {
      content = Container(
        padding: padding ?? const EdgeInsets.all(20),
        decoration: backgroundColor != null
            ? BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: content,
      );
    }

    return content;
  }
}

/// Data model for fare breakdown items
class FareBreakdownItem {
  final String label;
  final String value;
  final Color? labelColor;
  final Color? valueColor;
  final bool isTotal;

  FareBreakdownItem({
    required this.label,
    required this.value,
    this.labelColor,
    this.valueColor,
    this.isTotal = false,
  });
}

