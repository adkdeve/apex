import 'package:apex/app/core/core.dart';
import 'package:apex/app/modules/driver/shared/widgets/driver_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui'; // Needed for PathMetric

// Assuming your controller is in this path
import '../controllers/vehicle_checklist_controller.dart';

class VehicleChecklistView extends GetView<VehicleChecklistController> {
  const VehicleChecklistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized if not already
    Get.put(VehicleChecklistController());

    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: R.theme.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF252525),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Vehicle Checklist",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Subtitle Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                "Complete this checklist before you\nstart your shift.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: R.theme.driverGreyText,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Scrollable List
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Obx(() => _buildChecklistCard(
                      title: "1. Tires",
                      option1: "Good",
                      option2: "Needs Attention",
                      groupValue: controller.tireStatus.value,
                      onChanged: (val) => controller.updateStatus(
                          controller.tireStatus, val),
                      extraInput: _buildUploadBox(
                        label: "Upload\nPhoto",
                        onTap: () => controller.pickImage("Tires"),
                      ),
                    )),

                    Obx(() => _buildChecklistCard(
                      title: "2. Lights",
                      option1: "Working",
                      option2: "Not Working",
                      groupValue: controller.lightStatus.value,
                      onChanged: (val) => controller.updateStatus(
                          controller.lightStatus, val),
                      extraInput: _buildTextField(
                        controller.lightNoteController,
                      ),
                    )),

                    Obx(() => _buildChecklistCard(
                      title: "3. Cleanliness",
                      option1: "Clean",
                      option2: "Needs Cleaning",
                      groupValue: controller.cleanlinessStatus.value,
                      onChanged: (val) => controller.updateStatus(
                          controller.cleanlinessStatus, val),
                      extraInput: _buildUploadBox(
                        label: "Upload\nPhoto",
                        onTap: () => controller.pickImage("Cleanliness"),
                      ),
                    )),

                    Obx(() => _buildChecklistCard(
                      title: "4. Exterior Damage",
                      option1: "No Damage",
                      option2: "Upload Damage Photo",
                      groupValue: controller.damageStatus.value,
                      onChanged: (val) => controller.updateStatus(
                          controller.damageStatus, val),
                      extraInput: _buildUploadBox(
                        label: "Upload\nPhoto",
                        onTap: () => controller.pickImage("Exterior Damage"),
                      ),
                    )),

                    Obx(() => _buildChecklistCard(
                      title: "5. Windshield Condition",
                      option1: "OK",
                      option2: "Crack / Issue",
                      groupValue: controller.windshieldStatus.value,
                      onChanged: (val) => controller.updateStatus(
                          controller.windshieldStatus, val),
                      extraInput: _buildUploadBox(
                        label: "Upload\nPhoto",
                        onTap: () => controller.pickImage("Windshield"),
                      ),
                    )),

                    const SizedBox(height: 100), // Space for bottom button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Sticky Bottom Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: controller.submitChecklist,
            style: ElevatedButton.styleFrom(
              backgroundColor: R.theme.goldAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: const Text(
              "Submit Incident Report",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChecklistCard({
    required String title,
    required String option1,
    required String option2,
    required int groupValue,
    required Function(int) onChanged,
    required Widget extraInput,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: DriverCard(
        borderRadius: 16,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Checkbox Row
            Row(
              children: [
                Expanded(
                  child: _buildCustomCheckbox(
                    label: option1,
                    isSelected: groupValue == 0,
                    onTap: () => onChanged(0),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildCustomCheckbox(
                    label: option2,
                    isSelected: groupValue == 1,
                    onTap: () => onChanged(1),
                  ),
                ),
              ],
            ),

            // Extra Input (Upload Box or Text Field)
            // AnimatedSwitcher gives a smooth transition when opening/closing
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: groupValue == 1
                  ? Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: extraInput,
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomCheckbox({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isSelected ? R.theme.goldAccent : Colors.transparent,
              border: Border.all(
                color: isSelected ? R.theme.goldAccent : const Color(0xFF6B7280),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: isSelected
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFFE5E7EB), // Light grey for text
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadBox({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: DashedRoundedRectPainter(
          color: const Color(0xFF4B5563), // Dark grey dash color
          strokeWidth: 1.5,
          dashPattern: [6, 4],
        ),
        child: Container(
          width: 80,
          height: 80,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.upload_file_rounded, color: Colors.white70, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF4B5563)),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        maxLines: 3,
        decoration: InputDecoration(
          hintText: "Note (Optional)",
          hintStyle: TextStyle(color: R.theme.driverGreyText, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}

// Custom Painter for the Dashed Rounded Border
class DashedRoundedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final double radius;

  DashedRoundedRectPainter({
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.dashPattern = const [5, 3],
    this.radius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);

    // Logic to draw dashed path
    Path dashedPath = Path();
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        double len = dashPattern[0];
        if (distance + len > pathMetric.length) {
          len = pathMetric.length - distance;
        }
        dashedPath.addPath(
          pathMetric.extractPath(distance, distance + len),
          Offset.zero,
        );
        distance += dashPattern[0] + dashPattern[1];
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}