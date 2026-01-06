import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/core/core.dart';
import '../../../app/modules/rider/hourly_reservation/controllers/ride_booked_controller.dart';

class ExtendTimeSheet extends GetView<RideBookedController> {
  const ExtendTimeSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryGold = R.theme.goldAccent;
    const Color bgDark = Color(0xFF0B0B0C);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgDark,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            "Extending time",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Options
          Obx(
            () => Column(
              children: [
                _buildRadioOption(0, "Add 30 minutes", primaryGold),
                const SizedBox(height: 12),
                _buildRadioOption(1, "Add 60 minutes", primaryGold),
                const SizedBox(height: 12),
                _buildRadioOption(2, "Add 90 minutes", primaryGold),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Send Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: controller.confirmExtension,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGold,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Send",
                style: TextStyle(
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
    );
  }

  Widget _buildRadioOption(int value, String text, Color activeColor) {
    bool isSelected = controller.selectedExtensionOption.value == value;
    return GestureDetector(
      onTap: () => controller.selectedExtensionOption.value = value,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: isSelected ? activeColor : Colors.white10,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Custom Radio Circle
            Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? activeColor : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        color: activeColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
