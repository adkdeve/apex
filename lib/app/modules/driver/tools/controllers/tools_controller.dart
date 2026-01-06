import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class ToolsController extends GetxController {

  void onAddFuelLog() {
    Get.toNamed(Routes.ADD_FUEL_LOG);
  }

  void onStartChecklist() {
    Get.toNamed(Routes.VEHICLE_CHECKLIST);
  }

  void onSubmitIncident() {
    Get.toNamed(Routes.INCIDENT_REPORT);
  }

  void switchTab(int index) {
  }
}



