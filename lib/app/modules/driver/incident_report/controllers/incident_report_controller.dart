import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/helpers/validation_utils.dart';

class IncidentReportController extends GetxController with LoadingStateMixin {
  final formKey = GlobalKey<FormState>();
  final List<String> incidentTypes = [
    "Accident",
    "Breakdown",
    "Traffic Violation",
    "Theft",
    "Other",
  ];

  var selectedIncidentType = "Accident".obs;
  var attachedPhotos = <String>[].obs; // List to store photo paths

  final descriptionController = TextEditingController();

  void selectIncidentType(String? value) {
    if (value != null) {
      selectedIncidentType.value = value;
    }
  }

  Future<void> pickPhoto() async {
    try {
      if (attachedPhotos.length >= 5) {
        ErrorHandler.showWarning('You can only upload up to 5 photos');
        return;
      }

      // TODO: Implement actual image picker
      // final ImagePicker picker = ImagePicker();
      // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      // if (image != null) {
      //   attachedPhotos.add(image.path);
      // }

      attachedPhotos.add("dummy_path");
      ErrorHandler.showSuccess('Photo added (${attachedPhotos.length}/5)');
    } catch (e) {
      ErrorHandler.handleException(e, customMessage: 'Failed to pick photo');
    }
  }

  Future<void> sendReport() async {
    // Validate description
    if (descriptionController.text.trim().isEmpty) {
      ErrorHandler.showError('Please describe what happened');
      return;
    }

    if (descriptionController.text.trim().length < 10) {
      ErrorHandler.showError('Description must be at least 10 characters');
      return;
    }

    // Validate photos
    if (attachedPhotos.isEmpty) {
      ErrorHandler.showWarning('Consider adding photos to support your report');
    }

    await executeWithLoading(
      operation: () async {
        // TODO: Implement actual API call
        await Future.delayed(const Duration(seconds: 1));

        // Simulate sending report
        // await incidentRepository.submitReport(...);
      },
      showSuccessMessage: true,
      successMessage: 'Incident report submitted successfully!',
      errorMessage: 'Failed to submit report. Please try again.',
    );

    // Navigate back on success
    if (!isLoading) {
      Get.back();
    }
  }

  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }
}
