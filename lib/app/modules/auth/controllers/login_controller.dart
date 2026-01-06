import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Text Controllers for Input Fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable State Variables
  var isPasswordHidden = true.obs;
  var rememberMe = false.obs;
  var emailError = false.obs;
  var passwordError = false.obs;

  // Toggles
  var isPasswordVisible = false.obs;

  void handleLogin() {
    String email = emailController.text;
    String password = passwordController.text;
    bool hasError = false;

    // Email Validation
    if (email.isEmpty || !email.contains('@')) {
      emailError.value = true;
      hasError = true;
    } else {
      emailError.value = false;
    }

    // Password Validation
    if (password.isEmpty || password.length < 6) {
      passwordError.value = true;
      hasError = true;
    } else {
      passwordError.value = false;
    }

    if (!hasError) {
      Get.toNamed('otp');
    }
  }

  // Navigation actions
  void onForgotPassword() {
    Get.toNamed('/forgot-password');
  }

  void onRegister() {
    Get.offAllNamed('/register');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}