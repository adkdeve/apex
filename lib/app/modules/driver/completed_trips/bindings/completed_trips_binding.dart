import 'package:get/get.dart';
import '../controllers/completed_trips_controller.dart';

class CompletedTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedTripsController>(() => CompletedTripsController());
  }
}


