import 'package:get/get.dart';

import '../controllers/incident_report_controller.dart';

class IncidentReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncidentReportController>(
      () => IncidentReportController(),
    );
  }
}


