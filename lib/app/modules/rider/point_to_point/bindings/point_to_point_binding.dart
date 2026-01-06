import 'package:get/get.dart';

import '../controllers/point_to_point_controller.dart';

class PointToPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PointToPointController>(
      () => PointToPointController(),
    );
  }
}
