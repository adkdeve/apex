import 'dart:ui';
import 'package:apex/app/core/core.dart';
import 'package:apex/app/modules/driver/shared/widgets/driver_back_button.dart';
import 'package:apex/app/modules/driver/shared/widgets/driver_card.dart';
import 'package:apex/app/modules/driver/shared/utils/dashed_border_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/incident_report_controller.dart';

class IncidentReportView extends StatelessWidget {
  final IncidentReportController controller = Get.put(
    IncidentReportController(),
  );

  IncidentReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Main background
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      DriverBackButton(onPressed: () => Get.back()),
                      const Expanded(
                        child: Text(
                          "Incident Report",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40), // Balance the back button
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Submit Incident Report",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: R.theme.driverGreyText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Incident Type Selector"),
                    Obx(
                      () => DriverCard(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: controller.selectedIncidentType.value,
                              dropdownColor: R.theme.cardBgVariant,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              isExpanded: true,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              items: controller.incidentTypes.map((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: controller.selectIncidentType,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    _buildLabel("Description"),
                    Container(
                      height: 120, // Fixed height for large text area
                      decoration: BoxDecoration(
                        color: Colors
                            .transparent, // Transparent as per design (border only)
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: R.theme.driverBorderColor),
                      ),
                      child: TextField(
                        controller: controller.descriptionController,
                        maxLines: 10,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Describe what happened...",
                          hintStyle: TextStyle(color: R.theme.driverGreyText),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    _buildLabel("Add up to 5 photos"),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: controller.pickPhoto,
                          child: CustomPaint(
                            painter: DashedBorderPainter(),
                            child: Container(
                              width: 90,
                              height: 90,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.upload,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Upload Photo",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Just a placeholder to show where uploaded images would appear
                        // In a real app, you would map 'controller.attachedPhotos' here.
                      ],
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.sendReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: R.theme.goldAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Send Report",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
