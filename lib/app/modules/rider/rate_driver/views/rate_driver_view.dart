import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apex/common/widgets/navigation/custom_app_bar.dart';
import '../../../../core/core.dart';
import '../controllers/rate_driver_controller.dart';

class RateDriverView extends GetView<RateDriverController> {
  const RateDriverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RateDriverController());

    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      appBar: CustomAppBar(
        title: "Rate your Driver",
        backgroundColor: R.theme.darkBackground,
        backButtonColor: Colors.white24,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white10, width: 2),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: R.theme.cardBg,
                // Using an Icon here so it doesn't crash if you lack the asset
                // Swap this with backgroundImage: AssetImage("assets/images/driver.png") when ready
                child: Icon(Icons.person, size: 60, color: R.theme.grey),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Text(
                controller.driverName.value,
                style: TextStyle(
                  color: R.theme.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Obx(
              () => Text(
                controller.carModel.value,
                style: TextStyle(color: R.theme.grey, fontSize: 14),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "How is your trip?",
              style: TextStyle(
                color: R.theme.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () => controller.setRating(index + 1),
                    iconSize: 40,
                    icon: Icon(
                      Icons.star,
                      // If index is less than rating, show Gold, else show White/Grey
                      color: index < controller.rating.value
                          ? R.theme.secondary
                          : Colors.grey[700],
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Write your feedback",
                style: TextStyle(color: R.theme.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: R.theme.cardBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                maxLines: null, // Multiline support
                style: TextStyle(color: R.theme.white),
                onChanged: (value) => controller.setFeedback(value),
                decoration: const InputDecoration(
                  hintText: "Your experience...",
                  hintStyle: TextStyle(color: Colors.white24),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: R.theme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Submit Feedback",
                  style: TextStyle(
                    color: R.theme.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => controller.submitRating(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
