import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apex/common/widgets/navigation/custom_app_bar.dart';
import '../../../../core/core.dart';
import '../../rate_driver/views/rate_driver_view.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      appBar: const CustomAppBar(
        title: "Receipt",
        backButtonColor: Colors.white24,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 1. LOCATION SECTION (Current Location)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, color: Colors.redAccent, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Current location",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "2972 Westheimer Rd. Santa Ana, Illinois 85486",
                        style: TextStyle(color: Colors.grey[400], fontSize: 13, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // 2. DRIVER & CAR CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: R.theme.cardBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // Avatar
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=ben"), // Use asset if needed
                  ),
                  const SizedBox(width: 12),

                  // Name & Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ben Stokes",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, color: R.theme.secondary, size: 14),
                            const SizedBox(width: 4),
                            const Text("4.9", style: TextStyle(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text("Suzuki Alto", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                      ],
                    ),
                  ),

                  // Car Image & Plate
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Placeholder for car image
                      Image.network(
                        "https://purepng.com/public/uploads/large/purepng.com-grey-honda-accord-carcarhondahonda-automobileshonda-accord-17015274834870s99r.png",
                        width: 80,
                        height: 40,
                        fit: BoxFit.contain,
                        errorBuilder: (c,e,s) => const Icon(Icons.directions_car, color: Colors.white54),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "APT 238",
                          style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 3. PROMO CODE INPUT
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: R.theme.secondary),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Promo Code (if any)",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.secondary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      elevation: 0,
                    ),
                    child: const Text("Apply", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 4. PAYMENT METHOD
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Payment Method", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text("Card", style: TextStyle(color: R.theme.secondary, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.credit_card, color: Colors.white70, size: 30), // Closest to Mastercard generic
                    const SizedBox(width: 10),
                    const Text("**** 8295", style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(width: 12),
                    Icon(Icons.edit, color: R.theme.secondary, size: 18),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 5. HOURLY BREAKDOWN
            _buildFareRow("Pickup Time", "32:32:00 PM", R.theme.grey, R.theme.secondary),
            const SizedBox(height: 12),
            _buildFareRow("Hourly Rate", "\$100", R.theme.grey, R.theme.secondary),
            const SizedBox(height: 12),
            _buildFareRow("Booked hours", "3 hours", R.theme.grey, R.theme.secondary),
            const SizedBox(height: 12),
            _buildFareRow("Extended hours", "60 mins", R.theme.grey, R.theme.secondary),

            const SizedBox(height: 16),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Estimated total", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text("\$300,00", style: TextStyle(color: R.theme.secondary, fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),

            const SizedBox(height: 25),

            // 6. ADD TIP INPUT
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: R.theme.secondary),
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Add Tip for driver",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 7. PAY BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const RateDriverView()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: R.theme.secondary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text(
                  "Pay Now",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildFareRow(String label, String value, Color labelColor, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: labelColor, fontSize: 14)),
        Text(value, style: TextStyle(color: valueColor, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}