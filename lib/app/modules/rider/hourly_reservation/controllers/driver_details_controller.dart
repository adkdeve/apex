import 'package:apex/utils/helpers/snackbar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverDetailsController extends GetxController {
  // Mock Data (In a real app, this would come from an API)
  final driverName = "Ben Stokes".obs;
  final carModel = "Luxury SUV".obs;
  final carPlate = "APT 238".obs;
  final rating = "4.9".obs;

  // Ride Details
  final pickupLocation = "2972 Westheimer Rd. Santa Ana, Illinois 85486".obs;
  final pickupTime = "12:30 PM".obs; // Fixed the typo from image "32:32:00 PM"
  final hourlyRate = "\$100".obs;
  final bookedHours = "3 hours".obs;
  final estimatedTotal = "\$200,00".obs;

  void trackDriver() {
    SnackBarUtils.successMsg("Opening live map location...");
    // Navigate to a tracking map view if you have one
  }

  void callDriver() async {
    final Uri launchUri = Uri(scheme: 'tel', path: '1234567890');
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      SnackBarUtils.errorMsg("Could not launch dialer");
    }
  }

  void messageDriver() {
    // Navigate to chat screen
    // Get.toNamed('/chat');
    SnackBarUtils.successMsg("Opening chat...");
  }
}
