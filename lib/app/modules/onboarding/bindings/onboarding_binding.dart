import 'package:apex/app/modules/onboarding/controllers/role_selection_controller.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(),
    );
    Get.lazyPut<RoleSelectionController>(
      () => RoleSelectionController(),
    );
  }
}
