import 'package:get/get.dart';

import '../controllers/pricing_summary_controller.dart';

class PricingSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PricingSummaryController>(
      () => PricingSummaryController(),
    );
  }
}
