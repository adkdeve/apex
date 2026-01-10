import 'package:apex/app/modules/rider/ride_booked/views/ride_booked_view.dart';
import 'package:apex/app/data/models/ride_booking_data.dart';
import 'package:get/get.dart';
import 'package:apex/app/data/models/driver_model.dart';
import '../../../../../utils/helpers/snackbar.dart';

class DriversListController extends GetxController {
  late RideBookingData? bookingData;

  @override
  void onInit() {
    super.onInit();
    // Get booking data passed from previous screen
    bookingData = Get.arguments as RideBookingData?;
  }

  // --- MOCK DATA ---
  final drivers = <Driver>[
    Driver(
      name: "Ben Stroke",
      rating: 4.9,
      arrivalTime: "4 min.",
      distance: "844m",
      carModel: "SUZUKI ALTO",
      price: "15.00",
      imagePath: "assets/images/user1.png", // Replace with your asset
    ),
    Driver(
      name: "Esther Berry",
      rating: 4.9,
      arrivalTime: "10 min.",
      distance: "844m",
      carModel: "SUZUKI WAGON R",
      price: "25.00",
      imagePath: "assets/images/user2.png",
    ),
    Driver(
      name: "Esther Berry", // Same name in design sample
      rating: 4.9,
      arrivalTime: "4 min.",
      distance: "844m",
      carModel: "SUZUKI ALTO",
      price: "10.00",
      imagePath: "assets/images/user2.png",
    ),
  ].obs;

  // --- ACTIONS ---
  void acceptDriver(Driver driver) {
    // Create active ride data with selected driver
    final activeRide = ActiveRideData(
      bookingData:
          bookingData ??
          RideBookingData(
            pickupAddress: "Current Location",
            dropoffAddress: "Destination",
            pickupLat: 37.7749,
            pickupLng: -122.4194,
            dropoffLat: 37.7849,
            dropoffLng: -122.4094,
          ),
      driverId: "driver_${driver.name.hashCode}",
      driverName: driver.name,
      driverRating: driver.rating.toString(),
      driverPhone: "+1234567890",
      carModel: driver.carModel,
      plateNumber: "APT 238",
      arrivalTime: driver.arrivalTime,
      actualFare: driver.price,
    );

    Get.to(() => RideBookedView(), arguments: activeRide);
  }

  void declineDriver(int index) {
    drivers.removeAt(index);
    SnackBarUtils.successMsg("Driver removed from list");
  }
}
