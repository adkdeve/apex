import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/helpers/validation_utils.dart';

class AddFuelLogController extends GetxController with LoadingStateMixin {
  final formKey = GlobalKey<FormState>();
  final vendorController = TextEditingController();
  final gallonsController = TextEditingController();
  final costController = TextEditingController();
  final odometerController = TextEditingController();

  var selectedVehicle = "Select Vehicle".obs;

  final List<String> myVehicles = [
    "Toyota Camry (LEX-5563)",
    "Honda Civic (ABC-1234)",
  ];

  Future<void> pickReceiptImage() async {
    try {
      // TODO: Implement actual image picker
      ErrorHandler.showInfo('Opening camera to scan receipt...');
      // await ImagePicker().pickImage(source: ImageSource.camera);
    } catch (e) {
      ErrorHandler.handleException(e, customMessage: 'Failed to open camera');
    }
  }

  void selectVehicle() {
    Get.bottomSheet(
      Container(
        color: const Color(0xFF1E1E1E),
        child: Wrap(
          children: myVehicles
              .map(
                (vehicle) => ListTile(
                  title: Text(
                    vehicle,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    selectedVehicle.value = vehicle;
                    Get.back();
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Future<void> saveFuelLog() async {
    // Validate form
    if (!ErrorHandler.validateForm(formKey)) {
      return;
    }

    // Validate vehicle selection
    if (selectedVehicle.value == "Select Vehicle") {
      ErrorHandler.showError('Please select a vehicle');
      return;
    }

    await executeWithLoading(
      operation: () async {
        // TODO: Implement actual API call
        await Future.delayed(const Duration(seconds: 1));

        // Simulate save
        // await fuelLogRepository.saveFuelLog(...);
      },
      showSuccessMessage: true,
      successMessage: 'Fuel log added successfully!',
      errorMessage: 'Failed to save fuel log. Please try again.',
    );

    // Navigate back on success
    if (!isLoading) {
      Get.back();
    }
  }

  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    vendorController.dispose();
    gallonsController.dispose();
    costController.dispose();
    odometerController.dispose();
    super.onClose();
  }
}
