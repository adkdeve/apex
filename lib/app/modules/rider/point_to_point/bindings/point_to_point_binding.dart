import 'package:apex/app/data/services/saved_places_service.dart';
import 'package:apex/app/modules/rider/point_to_point/controllers/search_location_controller.dart';
import 'package:apex/app/modules/rider/point_to_point/controllers/ride_selection_controller.dart';
import 'package:apex/app/modules/rider/point_to_point/controllers/schedule_ride_controller.dart';
import 'package:get/get.dart';
import '../controllers/add_label_controller.dart';
import '../controllers/point_to_point_controller.dart';

class PointToPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedPlacesService>(() => SavedPlacesService(), fenix: true);
    Get.lazyPut<PointToPointController>(() => PointToPointController());
    Get.lazyPut<AddLabelController>(() => AddLabelController());
    Get.lazyPut<SearchLocationController>(
      () => SearchLocationController(),
      fenix: true,
    );
    Get.lazyPut<RideSelectionController>(() => RideSelectionController());
    Get.lazyPut<ScheduleRideController>(() => ScheduleRideController());
  }
}
