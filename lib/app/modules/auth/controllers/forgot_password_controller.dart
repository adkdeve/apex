import 'package:apex/utils/helpers/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  var emailError = false.obs;


  // Navigation Logic
  void onBack() {
    Get.back();
  }

  // Send Link Logic
  void handleSendLink() {
    String email = emailController.text.trim();
    bool hasError = false;


    // Email Validation
    if (email.isEmpty || !email.contains('@')) {
      emailError.value = true;
      hasError = true;
    } else {
      emailError.value = false;
    }

    if (!hasError) {
      print('Sending verification link to: $email');

      SnackBarUtils.successMsg("Verification link sent! Check your email.");
    } else {
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}