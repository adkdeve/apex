import 'dart:ui';
import 'package:apex/app/core/core.dart';
import 'package:apex/app/modules/driver/shared/utils/dashed_border_painter.dart';
import 'package:apex/app/modules/driver/shared/widgets/driver_header.dart';
import 'package:apex/utils/helpers/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_fuel_log_controller.dart';

class AddFuelLogView extends StatelessWidget {
  final AddFuelLogController controller = Get.put(AddFuelLogController());

  AddFuelLogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DriverHeader(
                title: "Add Fuel Log",
                subtitle: "Quick tools to manage your\nvehicle and trips",
                onBackPressed: controller.goBack,
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upload Receipt Photo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: controller.pickReceiptImage,
                        child: CustomPaint(
                          painter: DashedBorderPainter(
                            color: const Color(0xFF333333),
                          ),
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.upload_file,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Tap to upload",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      _buildLabel("Vendor Name"),
                      _buildTextField(
                        controller: controller.vendorController,
                        hint: "Enter fuel station name",
                        validator: (value) => Validators.validateRequired(
                          value,
                          fieldName: 'Vendor name',
                        ),
                      ),

                      const SizedBox(height: 16),

                      _buildLabel("Gallons / Liters"),
                      _buildTextField(
                        controller: controller.gallonsController,
                        hint: "0.00",
                        keyboardType: TextInputType.number,
                        validator: Validators.validateGallons,
                      ),

                      const SizedBox(height: 16),

                      _buildLabel("Total Amount"),
                      _buildTextField(
                        controller: controller.costController,
                        hint: "0.00",
                        keyboardType: TextInputType.number,
                        validator: Validators.validateCost,
                      ),

                      const SizedBox(height: 16),

                      _buildLabel("Odometer Reading"),
                      _buildTextField(
                        controller: controller.odometerController,
                        hint: "Enter mileage",
                        keyboardType: TextInputType.number,
                        validator: Validators.validateOdometer,
                      ),

                      const SizedBox(height: 16),

                      _buildLabel("Vehicle Selector"),
                      _buildDropdownTrigger(),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: controller.saveFuelLog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: R.theme.goldAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Save Fuel Log",
                            style: TextStyle(
                              color: Colors
                                  .white, // Text is white on gold in mockup
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: R.theme.driverBackground,
        border: Border.all(color: const Color(0xFF333333)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: R.theme.driverGreyText),
            border: InputBorder.none,
            errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownTrigger() {
    return Obx(
      () => GestureDetector(
        onTap: controller.selectVehicle,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: R.theme.driverBackground,
            border: Border.all(color: const Color(0xFF333333)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.selectedVehicle.value,
                style: TextStyle(
                  color: controller.selectedVehicle.value == "Select Vehicle"
                      ? R.theme.driverGreyText
                      : Colors.white,
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
