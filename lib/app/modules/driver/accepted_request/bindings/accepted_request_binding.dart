import 'package:get/get.dart';

import '../controllers/accepted_request_controller.dart';

class AcceptedRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcceptedRequestController>(() => AcceptedRequestController());
  }
}
