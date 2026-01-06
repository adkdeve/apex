import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../data/services/auth_service.dart';

class RoleSelectionController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  void selectRole(String role) {
    // Save the selected role to secure storage
    _authService.saveUserRole(role).then((_) {
      Get.offAllNamed(Routes.LOGIN);
    });
  }
}
