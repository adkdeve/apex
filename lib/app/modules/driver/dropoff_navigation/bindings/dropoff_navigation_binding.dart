import 'package:get/get.dart';

import '../controllers/dropoff_navigation_controller.dart';

class DropoffNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DropoffNavigationController>(
      () => DropoffNavigationController(),
    );
  }
}
