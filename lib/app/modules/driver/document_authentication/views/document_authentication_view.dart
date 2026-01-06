import 'package:apex/app/core/core.dart';
import 'package:apex/app/data/models/verification_step_model.dart';
import 'package:apex/app/modules/driver/document_authentication/views/photo_check_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/document_authentication_controller.dart';

class DocumentAuthenticationView
    extends GetView<DocumentAuthenticationController> {
  const DocumentAuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DocumentAuthenticationController());

    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}

// ---------------------------------------------
// 1. CONTROLLER
// ---------------------------------------------
class VerificationController extends GetxController {
  // The list of verification steps
  final steps = <VerificationStepModel>[
    VerificationStepModel(
      title: 'Your selfie',
      subtitle: 'Clear face photo',
      icon: Icons.account_box_outlined,
    ),
    VerificationStepModel(
      title: 'Vehicle details',
      subtitle: 'Basic vehicle info',
      icon: Icons.directions_car_outlined,
    ),
    VerificationStepModel(
      title: 'Photo of ID Card',
      subtitle: 'Valid ID image',
      icon: Icons.credit_card,
    ),
    VerificationStepModel(
      title: 'License',
      subtitle: 'Active driving license',
      icon: Icons.badge_outlined,
    ),
    VerificationStepModel(
      title: 'W-9 on file',
      subtitle: 'Tax form submission',
      icon: Icons.description_outlined,
    ),
  ].obs;

  void onGetStarted() {
    Get.to(() => PhotoCheckView());
  }
}

// ---------------------------------------------
// 3. VIEW
// ---------------------------------------------
class VerificationView extends StatelessWidget {
  // Dependency Injection
  final VerificationController controller = Get.put(VerificationController());

  VerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      // Using SafeArea to avoid notches on iPhone X+
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // --- Logo Section ---
              _buildLogo(),

              const SizedBox(height: 40),

              // --- Header Text ---
              const Text(
                "Start Verification",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "To start verify with Apex, we'll need:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 40),

              // --- List of Steps ---
              Expanded(
                child: Obx(() {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.steps.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 24),
                    itemBuilder: (context, index) {
                      return _buildStepItem(controller.steps[index]);
                    },
                  );
                }),
              ),

              // --- Bottom Button ---
              _buildBottomButton(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // A custom widget to simulate the Logo in the screenshot
  Widget _buildLogo() {
    return Column(
      children: [
        // Placeholder for the "A" logo
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: R.theme.goldAccent, width: 2),
          ),
          child: Icon(Icons.shield, color: R.theme.goldAccent, size: 30),
        ),
        const SizedBox(height: 8),
        // "APEX INTERNATIONAL" Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "APEX",
              style: TextStyle(
                color: R.theme.goldAccent,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "INTERNATIONAL",
              style: TextStyle(
                color: R.theme.goldAccent,
                fontSize: 8,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepItem(VerificationStepModel item) {
    return Row(
      children: [
        // Icon Circle
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: R.theme.goldAccent.withOpacity(
              0.9,
            ), // Slightly softer gold for icon bg
            shape: BoxShape.circle,
          ),
          child: Icon(
            item.icon,
            color: Colors.white, // Icon inside is white (mostly) or very light
            size: 24,
          ),
        ),
        const SizedBox(width: 16),

        // Text Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.subtitle,
                style: TextStyle(color: Colors.grey[500], fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: controller.onGetStarted,
        style: ElevatedButton.styleFrom(
          backgroundColor: R.theme.goldAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: const Text(
          "Get Started",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

