import 'package:apex/app/core/core.dart';
import 'package:apex/app/modules/driver/shared/widgets/driver_back_button.dart';
import 'package:apex/app/modules/driver/shared/utils/dashed_border_painter.dart';
import 'package:apex/app/data/models/vehicle_model.dart';
import 'package:apex/app/modules/driver/document_authentication/views/authentication_view.dart';
import 'package:apex/utils/helpers/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetupVehicleController extends GetxController with LoadingStateMixin {
  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Text Controllers for input fields
  final nameController = TextEditingController();
  final modelController = TextEditingController();
  final licensePlateController = TextEditingController();

  // Reactive model state
  final vehicle = VehicleModel().obs;
  final hasDocument = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    modelController.dispose();
    licensePlateController.dispose();
    super.onClose();
  }

  Future<void> pickDocument() async {
    try {
      // TODO: Implement file picker logic
      ErrorHandler.showInfo('Opening file picker...');
      // final result = await FilePicker.platform.pickFiles(...);
      // if (result != null) {
      //   hasDocument.value = true;
      //   vehicle.update((val) => val?.documentPath = result.files.single.path);
      // }

      hasDocument.value = true;
    } catch (e) {
      ErrorHandler.handleException(e, customMessage: 'Failed to pick document');
    }
  }

  Future<void> saveVehicle() async {
    // Validate form
    if (!ErrorHandler.validateForm(formKey)) {
      return;
    }

    // Validate document upload
    if (!hasDocument.value) {
      ErrorHandler.showError('Please upload vehicle registration document');
      return;
    }

    await executeWithLoading(
      operation: () async {
        // Update model
        vehicle.update((val) {
          val?.name = nameController.text.trim();
          val?.model = modelController.text.trim();
          val?.licensePlate = licensePlateController.text.trim().toUpperCase();
        });

        // TODO: Implement actual API call
        await Future.delayed(const Duration(milliseconds: 500));

        // Simulate saving vehicle
        // await vehicleRepository.saveVehicle(vehicle.value);
      },
      showSuccessMessage: true,
      successMessage: 'Vehicle information saved successfully!',
      errorMessage: 'Failed to save vehicle information. Please try again.',
    );

    // Navigate to next screen on success
    if (!isLoading) {
      Get.to(() => AuthenticationView());
    }
  }
}

class SetupVehicleView extends StatelessWidget {
  // Dependency Injection
  final SetupVehicleController controller = Get.put(SetupVehicleController());

  SetupVehicleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      // SafeArea to respect notches
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // --- Header ---
                Row(
                  children: [
                    DriverBackButton(onPressed: () => Get.back()),
                    const Expanded(
                      child: Text(
                        "Setup vehicle",
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

                const SizedBox(height: 24),

                // --- Subtitle ---
                const Center(
                  child: Text(
                    "Please provide us your vehicle legal\ndocuments to proceed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // --- Form Fields ---
                _buildLabel("Vehicle name"),
                _buildTextField(
                  controller: controller.nameController,
                  hint: "e.g., Toyota Camry",
                  validator: Validators.validateVehicleName,
                ),
                const SizedBox(height: 20),

                _buildLabel("Vehicle model"),
                _buildTextField(
                  controller: controller.modelController,
                  hint: "e.g., 2022",
                  validator: (value) => Validators.validateRequired(
                    value,
                    fieldName: 'Vehicle model',
                  ),
                ),
                const SizedBox(height: 20),

                _buildLabel("Vehicle license plate"),
                _buildTextField(
                  controller: controller.licensePlateController,
                  hint: "e.g., LEX-5563",
                  validator: Validators.validateLicensePlate,
                ),

                const SizedBox(height: 24),

                // --- Upload Area (Dashed Border) ---
                GestureDetector(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.upload_file, color: Colors.grey, size: 24),
                          SizedBox(height: 8),
                          Text(
                            "Tap to upload",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // --- Save Button ---
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: controller.saveVehicle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.goldAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Save",
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
      ),
    );
  }

  // Helper: Input Label
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Helper: Text Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: R.theme.driverGreyText),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: R.theme.driverBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: R.theme.goldAccent),
        ),
      ),
    );
  }
}
