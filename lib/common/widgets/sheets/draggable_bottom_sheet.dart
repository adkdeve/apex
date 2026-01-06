import 'package:flutter/material.dart';

/// Reusable draggable bottom sheet with handle
/// Used in: point_to_point_view, ride_selection_view, ride_booked_view
class DraggableBottomSheet extends StatelessWidget {
  const DraggableBottomSheet({
    Key? key,
    required this.controller,
    required this.child,
    this.initialChildSize = 0.55,
    this.minChildSize = 0.25,
    this.maxChildSize = 0.65,
    this.backgroundColor,
    this.borderRadius,
    this.handleColor,
    this.padding,
    this.onSheetChanged,
  }) : super(key: key);

  final DraggableScrollableController controller;
  final Widget child;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color? handleColor;
  final EdgeInsets? padding;
  final ValueChanged<double>? onSheetChanged;

  @override
  Widget build(BuildContext context) {
    final Color defaultBg = backgroundColor ?? const Color(0xFF0B0B0C);
    final BorderRadius defaultRadius = borderRadius ??
        const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        );

    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (context, scrollController) {
        // Notify parent of sheet height changes if callback provided
        if (onSheetChanged != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
            if (renderBox != null) {
              final height = renderBox.size.height;
              final screenHeight = MediaQuery.of(context).size.height;
              onSheetChanged!(height / screenHeight);
            }
          });
        }

        return Container(
          decoration: BoxDecoration(
            color: defaultBg,
            borderRadius: defaultRadius,
          ),
          child: ListView(
            controller: scrollController,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            children: [
              // Handle Bar
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: handleColor ?? Colors.grey[800],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              child,
            ],
          ),
        );
      },
    );
  }
}

