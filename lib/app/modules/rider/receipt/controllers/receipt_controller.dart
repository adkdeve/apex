import 'package:get/get.dart';
import 'package:apex/app/data/models/ride_booking_data.dart';

class ReceiptController extends GetxController {
  late ActiveRideData? activeRideData;

  // Observable fields for dynamic content
  var driverName = "Driver".obs;
  var pickupAddress = "Pickup Location".obs;
  var dropoffAddress = "Dropoff Location".obs;
  var pickupTime = "7:34 AM".obs;
  var dropTime = "7:48 AM".obs;
  var totalFare = "20.00".obs;
  var baseFare = "9.00".obs;
  var distanceFare = "9.00".obs;
  var timeFare = "2.00".obs;
  var travelTime = "~44min.".obs;

  @override
  void onInit() {
    super.onInit();

    // Get active ride data from previous screen
    activeRideData = Get.arguments as ActiveRideData?;

    if (activeRideData != null) {
      driverName.value = activeRideData!.driverName;
      pickupAddress.value = activeRideData!.bookingData.pickupAddress;
      dropoffAddress.value = activeRideData!.bookingData.dropoffAddress;
      totalFare.value = activeRideData!.actualFare;
      travelTime.value = activeRideData!.bookingData.estimatedTime ?? "~44min.";

      // Calculate fare breakdown (simplified)
      double total = double.tryParse(activeRideData!.actualFare) ?? 20.0;
      baseFare.value = (total * 0.45).toStringAsFixed(2);
      distanceFare.value = (total * 0.45).toStringAsFixed(2);
      timeFare.value = (total * 0.10).toStringAsFixed(2);
    }
  }
}
