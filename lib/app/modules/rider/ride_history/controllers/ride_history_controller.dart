import 'package:get/get.dart';
import 'package:apex/app/data/models/ride_history_model.dart';

class RideHistoryController extends GetxController {
  var isLoading = true.obs;
  var currentFilter = "This Month".obs;

  // List to hold different types of ride data
  var historyItems = <RideHistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistory();
  }

  void fetchHistory() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // Simulate API

    historyItems.value = [
      RideHistoryModel(
        type: RideType.standard,
        pickupTime: "7:34 AM",
        dropTime: "7:48 AM",
        pickupLocation: "State Park",
        dropLocation: "Home",
        driverName: "Michael Bracewell",
        rating: 4.9,
        price: "9.00",
        imageUrl: "https://i.pravatar.cc/150?img=11",
      ),
      RideHistoryModel(
        type: RideType.rental, // Represents the complex card in your design
        pickupTime: "32:32:00 PM", // As per your design text
        pickupLocation: "2972 Westheimer Rd. Santa Ana",
        driverName: "Ben Stokes",
        rating: 4.9,
        price: "100", // Hourly rate
        carName: "Luxury SUV",
        bookedHours: "3 hours",
        imageUrl: "https://i.pravatar.cc/150?img=59",
      ),
    ];

    isLoading.value = false;
  }
}
