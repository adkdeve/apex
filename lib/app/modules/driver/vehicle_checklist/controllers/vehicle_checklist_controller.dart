import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/helpers/validation_utils.dart';

class VehicleChecklistController extends GetxController with LoadingStateMixin {
  var tireStatus = 0.obs;
  var lightStatus = 0.obs;
  var cleanlinessStatus = 0.obs;
  var damageStatus = 0.obs;
  var windshieldStatus = 0.obs;

  final lightNoteController = TextEditingController();

  void updateStatus(RxInt observable, int value) {
    observable.value = value;
  }

  Future<void> pickImage(String sectionName) async {
    try {
      // TODO: Implement actual image picker
      ErrorHandler.showInfo('Opening camera for $sectionName');
      // final ImagePicker picker = ImagePicker();
      // final XFile? image = await picker.pickImage(source: ImageSource.camera);
    } catch (e) {
      ErrorHandler.handleException(e, customMessage: 'Failed to open camera');
    }
  }

  Future<void> submitChecklist() async {
    // Validate that all sections are checked
    if (tireStatus.value == 0 ||
        lightStatus.value == 0 ||
        cleanlinessStatus.value == 0 ||
        damageStatus.value == 0 ||
        windshieldStatus.value == 0) {
      ErrorHandler.showError(
        'Please complete all checklist items before submitting',
      );
      return;
    }

    // Check if any issue is reported and requires a note
    if (lightStatus.value == 2 && lightNoteController.text.trim().isEmpty) {
      ErrorHandler.showError('Please add a note for the light issue');
      return;
    }

    await executeWithLoading(
      operation: () async {
        // TODO: Implement actual API call
        await Future.delayed(const Duration(seconds: 1));

        // Simulate submission
        // await checklistRepository.submitChecklist(...);
      },
      showSuccessMessage: true,
      successMessage: 'Daily checklist submitted successfully!',
      errorMessage: 'Failed to submit checklist. Please try again.',
    );

    // Navigate back on success
    if (!isLoading) {
      Get.back();
    }
  }

  @override
  void onClose() {
    lightNoteController.dispose();
    super.onClose();
  }
}
