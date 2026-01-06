import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/helpers/validation_utils.dart';

class ContactController extends GetxController with LoadingStateMixin {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  var countryCode = '+880'.obs;

  Future<void> sendMessage() async {
    // Validate form
    if (!ErrorHandler.validateForm(formKey)) {
      return;
    }

    await executeWithLoading(
      operation: () async {
        // TODO: Implement actual API call
        await Future.delayed(const Duration(seconds: 1));

        // Simulate sending message
        // await contactRepository.sendMessage(...);
      },
      showSuccessMessage: true,
      successMessage: 'Your message has been sent successfully!',
      errorMessage: 'Failed to send message. Please try again.',
    );

    // Clear form on success
    if (!isLoading) {
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      messageController.clear();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
