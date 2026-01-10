import 'package:get/get.dart';
import '../controllers/ride_selection_controller.dart';

class RideSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideSelectionController>(
          () => RideSelectionController(),
    );
  }
}
