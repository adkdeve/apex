import 'dart:ui';

import 'package:apex/app/core/core.dart';
import 'package:apex/app/modules/driver/shared/widgets/driver_back_button.dart';
import 'package:apex/app/modules/driver/shared/utils/dashed_border_painter.dart';
import 'package:apex/app/modules/driver/document_authentication/views/w9_form_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ---------------------------------------------
// 1. CONTROLLER
// ---------------------------------------------
class AuthenticationController extends GetxController {
  // 1 = ID Card Step, 2 = Driver License Step
  var currentStep = 1.obs;

  // Store file paths (simulated)
  var idFrontPath = ''.obs;
  var idBackPath = ''.obs;
  var licenseFrontPath = ''.obs;
  var licenseBackPath = ''.obs;

  // Helper to check if current step files are uploaded (for submit logic)
  bool get canSubmitStep1 => idFrontPath.isNotEmpty && idBackPath.isNotEmpty;
  bool get canSubmitStep2 =>
      licenseFrontPath.isNotEmpty && licenseBackPath.isNotEmpty;

  void showImagePicker(String type) {
    Get.bottomSheet(
      ImagePickerSheet(
        onCamera: () {
          _simulateUpload(type);
          Get.back();
        },
        onGallery: () {
          _simulateUpload(type);
          Get.back();
        },
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  void _simulateUpload(String type) {
    // Simulating a file path
    String fakePath = 'path/to/image.jpg';
    if (currentStep.value == 1) {
      if (type == 'front') idFrontPath.value = fakePath;
      if (type == 'back') idBackPath.value = fakePath;
    } else {
      if (type == 'front') licenseFrontPath.value = fakePath;
      if (type == 'back') licenseBackPath.value = fakePath;
    }
  }

  void submit() {
    if (currentStep.value == 1) {
      // Move to Step 2
      currentStep.value = 2;
    } else {
      Get.to(() => W9FormView());
    }
  }

  void goBack() {
    if (currentStep.value == 2) {
      currentStep.value = 1;
    } else {
      Get.back();
    }
  }
}

// ---------------------------------------------
// 2. VIEW
// ---------------------------------------------

class AuthenticationView extends StatelessWidget {
  final AuthenticationController controller = Get.put(
    AuthenticationController(),
  );

  AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // --- Header ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  DriverBackButton(onPressed: controller.goBack),
                  const Expanded(
                    child: Text(
                      "Authentication",
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
            ),
            const SizedBox(height: 30),

            // --- Stepper (UPDATED) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Obx(() => _buildStepper()),
            ),

            const SizedBox(height: 30),

            // --- Form Content ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(() {
                  bool isStep1 = controller.currentStep.value == 1;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUploadSection(
                        title: isStep1
                            ? "Please upload front image of your ID card."
                            : "Please upload front image of your driver's license",
                        type: 'front',
                        imagePath: isStep1
                            ? controller.idFrontPath.value
                            : controller.licenseFrontPath.value,
                      ),
                      const SizedBox(height: 24),
                      _buildUploadSection(
                        title: isStep1
                            ? "Please upload Back image of your ID card."
                            : "Please upload Back image of your driver's license",
                        type: 'back',
                        imagePath: isStep1
                            ? controller.idBackPath.value
                            : controller.licenseBackPath.value,
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                }),
              ),
            ),

            // --- Submit Button ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: controller.submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: R.theme.goldAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Submit",
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

  // --- Helper Widgets ---

  Widget _buildStepper() {
    bool isStep2 = controller.currentStep.value == 2;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // 1. Align items to top
      children: [
        _buildStepCircle("1", "Upload ID card", isActive: true),

        // 2. The Line connecting the circles
        Expanded(
          child: Container(
            // 3. Offset calculation: Circle height is 30px. Center is 15px.
            //    Line height is 2px. Top margin = 15 - 1 = 14px.
            margin: const EdgeInsets.only(top: 14, left: 5, right: 5),
            height: 2,
            // 4. Color Logic: Grey if step 1, Gold if step 2.
            color: isStep2 ? R.theme.goldAccent : const Color(0xFF3A3A3A),
          ),
        ),

        _buildStepCircle("2", "Upload Driver License", isActive: isStep2),
      ],
    );
  }

  Widget _buildStepCircle(
    String number,
    String label, {
    required bool isActive,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? R.theme.goldAccent : Colors.transparent,
            shape: BoxShape.circle,
            border: isActive
                ? null
                : Border.all(color: Colors.grey[600]!, width: 1.5),
          ),
          child: Text(
            number,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );
  }

  Widget _buildUploadSection({
    required String title,
    required String type,
    required String imagePath,
  }) {
    const double radius = 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => controller.showImagePicker(type),
          child: CustomPaint(
            // Ensure you use the updated Painter class below
            painter: DashedBorderPainter(
              color: const Color(0xFF3A3A3A),
              strokeWidth: 1.5,
              gap: 6,
            ),
            child: Container(
              width: double.infinity,
              height: 160,
              alignment: Alignment.center,
              child: imagePath.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.upload_file, color: Colors.grey, size: 24),
                        SizedBox(height: 8),
                        Text(
                          "Tap to upload",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: Container(
                        color: Colors.grey[900],
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: Icon(
                            Icons.check_circle,
                            color: R.theme.goldAccent,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
} // ---------------------------------------------

// 3. BOTTOM SHEET COMPONENT
// ---------------------------------------------
class ImagePickerSheet extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  const ImagePickerSheet({
    Key? key,
    required this.onCamera,
    required this.onGallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 30),
          _buildSheetButton("Take a picture", onTap: onCamera),
          const Divider(color: Colors.grey, height: 1, thickness: 0.2),
          _buildSheetButton("Choose a picture", onTap: onGallery),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC7A049),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
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

  Widget _buildSheetButton(String text, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
