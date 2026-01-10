import 'package:apex/app/modules/rider/point_to_point/controllers/add_label_controller.dart';
import 'package:get/get.dart';

class AddLabelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLabelController>(
          () => AddLabelController(),
    );
  }
}
