import 'package:get/get.dart';

import '../../../../../utils/helpers/snackbar.dart';
import '../../../../routes/app_pages.dart';

class RequestsController extends GetxController {
  final List<String> filters = ["Available", "Upcoming", "Today", "Soon"];
  var selectedFilterIndex = 0.obs;

  void changeFilter(int index) {
    selectedFilterIndex.value = index;
  }

  final requestData = {
    "type": "Hourly Ride",
    "passengerName": "Esther Berry",
    "passengerImage": "https://i.pravatar.cc/150?img=5", // Placeholder
    "pickupAddress": "7958 Swift Village",
    "pickupDate": "18-12-2025",
    "pickupTime": "12:32:00 PM",
    "hourlyRate": "\$100",
    "bookedHours": "3 hours",
    "estimatedTotal": "\$200,00",
  };

  void onViewProfile() {
    Get.toNamed(Routes.REQUEST_DETAIL, arguments: requestData);
  }

  void onIgnore() {
    SnackBarUtils.successMsg("You have ignored this request.");
  }

  void onAccept() {
    SnackBarUtils.successMsg("Trip scheduled successfully!");
  }

  void goBack() {
    Get.back();
  }
}
