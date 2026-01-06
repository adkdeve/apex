import 'package:apex/app/core/core.dart';
import 'package:apex/app/modules/driver/shared/widgets/driver_back_button.dart';
import 'package:apex/app/modules/driver/shared/utils/dashed_border_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/helpers/snackbar.dart';
import 'approvals_view.dart';

// ---------------------------------------------
// 1. CONTROLLER
// ---------------------------------------------
class W9FormController extends GetxController {
  // Reactive state for the document path
  var documentPath = ''.obs;

  // Reactive state for verification status
  // Options: 'not_verified', 'pending', 'verified'
  var status = 'not_verified'.obs;

  void pickDocument() {
    // TODO: Implement file picker logic here
    // Simulating a successful pick
    documentPath.value = 'w9_form_signed.pdf';
    print("Document selected: ${documentPath.value}");
  }

  void verify() {
    if (documentPath.value.isEmpty) {
      SnackBarUtils.errorMsg("Please upload a document first");
      return;
    }

    // Simulate verification process
    status.value = 'pending';
    Get.to(() => ApprovalsView());
  }
}

// ---------------------------------------------
// 2. VIEW
// ---------------------------------------------
class W9FormView extends StatelessWidget {
  final W9FormController controller = Get.put(W9FormController());

  final Color kCircleBg = const Color(0xFF1F1F1F); // Dark grey circle bg

  W9FormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.theme.driverBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // --- Header ---
              _buildHeader(),

              const SizedBox(height: 40),

              // --- Status Indicator (Big Circle) ---
              _buildStatusIndicator(),

              const SizedBox(height: 50),

              // --- Upload Section ---
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Upload Document To Verify",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Obx(() => _buildUploadBox()),

              const Spacer(),

              // --- Verify Button ---
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: controller.verify,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: R.theme.goldAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Verify",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          children: [
            DriverBackButton(onPressed: () => Get.back()),
            const Expanded(
              child: Text(
                "W-9 Form",
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
          "Required for tax verification",
          style: TextStyle(color: R.theme.driverGreyText, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: R.theme.goldAccent,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.priority_high_rounded, // Exclamation mark
            size: 50,
            color: Colors.black, // Icon is black in the design
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Not Verified",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadBox() {
    bool hasFile = controller.documentPath.value.isNotEmpty;

    return GestureDetector(
      onTap: controller.pickDocument,
      child: CustomPaint(
        foregroundPainter: DashedBorderPainter(
          color: Colors.grey[700]!,
          strokeWidth: 1.5,
          gap: 5,
        ),
        child: Container(
          width: double.infinity,
          height: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: hasFile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: R.theme.goldAccent,
                      size: 30,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.documentPath.value, // Show filename
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      "Tap to change",
                      style: TextStyle(
                        color: R.theme.driverGreyText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.upload_file,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Tap to upload",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
