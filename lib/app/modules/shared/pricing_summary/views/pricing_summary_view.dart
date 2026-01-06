import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/core.dart';
import '../controllers/pricing_summary_controller.dart';

class PricingSummaryView extends GetView<PricingSummaryController> {
  const PricingSummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inject the controller
    Get.put(PricingSummaryController());

    // --- Colors & Styles ---
    const Color bgDark = Color(0xFF0B0B0C);
    const Color cardBg = Color(0xFF1F1F1F);
    final Color primaryGold = R.theme.goldAccent;
    const Color textWhite = Colors.white;
    const Color textGrey = Colors.grey;

    return Scaffold(
      backgroundColor: bgDark,
      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: bgDark,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pricing summary",
          style: TextStyle(
            color: textWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white24,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ),

      // --- BODY ---
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Pricing Card ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildPricingRow(
                    "Hourly Rate",
                    controller.hourlyRate,
                    textGrey,
                    primaryGold,
                  ),
                  const SizedBox(height: 16),
                  _buildPricingRow(
                    "Booked hours",
                    controller.bookedHours,
                    textGrey,
                    primaryGold,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: Colors.white10, height: 1),
                  ),
                  _buildPricingRow(
                    "Estimated total",
                    controller.estimatedTotal,
                    textWhite,
                    primaryGold,
                    isTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- Note Section ---
            const Text(
              "Note:",
              style: TextStyle(
                color: textWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Extra time during the ride leads to extra charges in 30 minute blocks at the same rate.",
              style: TextStyle(color: textGrey, fontSize: 14, height: 1.5),
            ),

            const Spacer(),

            // --- Confirm Button ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: controller.confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGold,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Confirm Bookings",
                  style: TextStyle(
                    color: textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 6),

            // --- Edit Details Button ---
            Center(
              child: TextButton(
                onPressed: controller.editDetails,
                child: const Text(
                  "Edit Details",
                  style: TextStyle(color: textWhite, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  // --- Helper Widget for Pricing Rows ---
  Widget _buildPricingRow(
    String label,
    String value,
    Color labelColor,
    Color valueColor, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
