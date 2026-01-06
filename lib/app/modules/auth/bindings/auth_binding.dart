import 'package:apex/app/modules/auth/controllers/login_controller.dart';
import 'package:apex/app/modules/auth/controllers/otp_controller.dart';
import 'package:apex/app/modules/auth/controllers/register_controller.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/forgot_password_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
    Get.lazyPut<OtpController>(() => OtpController());
  }
}
