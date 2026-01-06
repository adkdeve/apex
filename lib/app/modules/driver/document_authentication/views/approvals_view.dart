import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/core.dart';

// ---------------------------------------------
// 1. CONTROLLER
// ---------------------------------------------
class ApprovalsController extends GetxController {
  // Simulating a status check
  @override
  void onInit() {
    super.onInit();
    _checkStatus();
  }

  void _checkStatus() async {
    // Simulate waiting for backend approval
    await Future.delayed(const Duration(seconds: 3));
    print("Checking approval status...");
    // You could navigate to Home automatically here if approved
    // Get.offAll(() => HomeView());
  }
}

// ---------------------------------------------
// 2. VIEW
// ---------------------------------------------
class ApprovalsView extends StatelessWidget {
  final ApprovalsController controller = Get.put(ApprovalsController());

  ApprovalsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.theme.driverBackground,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // --- Header ---
            const Center(
              child: Text(
                "Approvals",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // --- Centered Content ---
            Expanded(
              child: Center(
                child: _buildStatusCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        color: R.theme.cardBgVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Shrink to fit content
        children: [
          // Icon Circle
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: R.theme.goldAccent,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.priority_high_rounded,
              size: 40,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 24),

          // Title
          const Text(
            "Your Approval is Pending",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          // Subtitle
          Text(
            "Wait for Confirmation Message\nYou will be directed to homepage\nonce your approval is accepted.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: R.theme.driverGreyText,
              fontSize: 14,
              height: 1.5, // Line height for readability
            ),
          ),
        ],
      ),
    );
  }
}

