import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedRideType = 'point-to-point'.obs;

  void selectRideType(String id) {
    selectedRideType.value = id;
  }

  void onCancelRide() {
    print("Cancel Ride");
  }
}