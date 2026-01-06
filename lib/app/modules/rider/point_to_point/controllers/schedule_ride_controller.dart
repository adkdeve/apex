import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/helpers/snackbar.dart';
import '../../../../core/core.dart';

class ScheduleRideController extends GetxController {
  // Text Controllers
  final pickupController = TextEditingController();
  final destController = TextEditingController();
  final stopController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final noteController = TextEditingController();

  // State Variables
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;
  var pickupWindow = "5 min".obs;

  // New State: Controls visibility of fare breakdown
  var isFareCalculated = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Default values
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    timeController.text = formatTime(TimeOfDay.now());
  }

  @override
  void onClose() {
    pickupController.dispose();
    destController.dispose();
    stopController.dispose();
    dateController.dispose();
    timeController.dispose();
    noteController.dispose();
    super.onClose();
  }

  // --- Actions ---

  void onMainButtonClick() {
    if (isFareCalculated.value) {
      findDriver();
    } else {
      calculateFare();
    }
  }

  void calculateFare() {
    // Simulate API call or calculation
    // In a real app, validate inputs here first
    isFareCalculated.value = true;
  }

  void findDriver() {
    SnackBarUtils.successMsg("Looking for a driver...");
  }

  void addStop() {
    SnackBarUtils.successMsg("Add stop clicked");
  }

  // --- Pickers ---
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) => _darkThemePicker(child!),
    );
    if (picked != null) {
      selectedDate.value = picked;
      dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      builder: (context, child) => _darkThemePicker(child!),
    );
    if (picked != null) {
      selectedTime.value = picked;
      timeController.text = formatTime(picked);
    }
  }

  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm:ss').format(dt);
  }

  Theme _darkThemePicker(Widget child) {
    return Theme(
      data: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: R.theme.goldAccent,
          onPrimary: Colors.black,
          surface: const Color(0xFF1F1F1F),
          onSurface: Colors.white,
        ),
      ),
      child: child,
    );
  }
}
