import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apex/app/data/models/ride_booking_data.dart';
import 'package:apex/common/widgets/sheets/success_bottom_sheet.dart';
import 'package:apex/app/routes/app_pages.dart';

import '../../../../../utils/helpers/snackbar.dart';
import '../../../../core/core.dart';

class RateDriverController extends GetxController {
  late ActiveRideData? activeRideData;

  // Observable fields
  var driverName = "Driver".obs;
  var carModel = "Vehicle".obs;
  var rating = 0.obs;
  var feedback = "".obs;

  @override
  void onInit() {
    super.onInit();

    // Get active ride data from previous screen
    activeRideData = Get.arguments as ActiveRideData?;

    if (activeRideData != null) {
      driverName.value = activeRideData!.driverName;
      carModel.value = activeRideData!.carModel;
    }
  }

  void setRating(int value) {
    rating.value = value;
  }

  void setFeedback(String text) {
    feedback.value = text;
  }

  void submitRating(BuildContext context) {
    if (rating.value == 0) {
      SnackBarUtils.errorMsg("Please select a rating before submitting");
      return;
    }

    // TODO: Submit rating to backend
    // Show success bottom sheet
    SuccessBottomSheet(
      title: "Thank you",
      message: "Thank you for your valuable feedback",
      buttonText: "Back To Home",
      onButtonPressed: () => Get.offAllNamed(Routes.MAIN),
      iconColor: R.theme.secondary,
      backgroundColor: R.theme.darkBackground,
      showHandle: false,
    ).show(context);
  }
}
