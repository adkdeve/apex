import 'package:apex/app/modules/rider/home/controllers/home_controller.dart';
import 'package:apex/app/modules/shared/profile/controllers/profile_controller.dart';
import 'package:apex/app/modules/shared/wallet/controllers/wallet_controller.dart';
import 'package:get/get.dart';
import '../../rider/ride_history/controllers/ride_history_controller.dart';
import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => WalletController());
    Get.lazyPut(() => RideHistoryController());
    Get.lazyPut(() => ProfileController());
  }
}
