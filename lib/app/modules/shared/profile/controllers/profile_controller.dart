import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/helpers/snackbar.dart';

class ProfileController extends GetxController {
  // --- State Variables (The Source of Truth) ---
  var isLoading = true.obs;
  var firstName = "Ben".obs;
  var lastName = "Stokes".obs;
  var email = "ben.stokes@email.com".obs;
  var phone = "+1 234 567 8900".obs;
  var city = "New York".obs;
  var profileImageUrl = "https://i.pravatar.cc/300".obs;

  // --- Text Editing Controllers (For the Form Input) ---
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController cityController;

  @override
  void onInit() {
    super.onInit();
    // 1. Initialize Text Controllers
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    cityController = TextEditingController();

    // 2. Fetch Data
    fetchProfile();
  }

  @override
  void onClose() {
    // 3. Dispose Controllers to prevent memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    super.onClose();
  }

  // --- Logic ---

  void fetchProfile() async {
    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));

    // In a real app, you would fetch JSON here.
    // For now, we use the default .obs values, but we MUST sync them to the TextControllers
    _syncModelToControllers();

    isLoading.value = false;
  }

  void onSaveProfile() async {
    // 1. Validate inputs (basic example)
    if (emailController.text.isEmpty || firstNameController.text.isEmpty) {
      SnackBarUtils.errorMsg("Please fill in all required fields");
      return;
    }

    isLoading.value = true;

    // 2. Simulate API Save
    await Future.delayed(const Duration(seconds: 1));

    // 3. Update Observable State (Source of Truth) from Inputs
    firstName.value = firstNameController.text;
    lastName.value = lastNameController.text;
    email.value = emailController.text;
    phone.value = phoneController.text;
    city.value = cityController.text;

    isLoading.value = false;

    // 4. Success Feedback
    Get.back(); // Optional: Close screen if needed
    SnackBarUtils.successMsg("Profile updated successfully");
  }

  void onPickImage() {
    // Logic to pick image from gallery/camera
    print("Pick image called");
  }

  // Helper to fill text fields with current state
  void _syncModelToControllers() {
    firstNameController.text = firstName.value;
    lastNameController.text = lastName.value;
    emailController.text = email.value;
    phoneController.text = phone.value;
    cityController.text = city.value;
  }
}
