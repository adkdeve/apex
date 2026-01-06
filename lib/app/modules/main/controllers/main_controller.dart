import 'package:flutter/foundation.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import '../../../data/services/auth_service.dart';

enum NavTab {
  home,
  wallet,
  history,
  profile,
  // Driver tabs
  dashboard,
  maps,
  schedules,
  tools,
}

class MainController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  var userName = "John Doe".obs;
  var activeTab = NavTab.home.obs;
  final role = 'rider'.obs;

  final advancedDrawerController = AdvancedDrawerController();

  void changeTab(NavTab tab) {
    activeTab.value = tab;
  }

  bool get isDriver => role.value.toLowerCase() == 'driver';

  void toggleDrawer() {
    try {
      advancedDrawerController.showDrawer();
    } catch (e) {
      // Controller is disposed, ignore the action
      debugPrint('AdvancedDrawerController is disposed: $e');
    }
  }

  @override
  void onClose() {
    advancedDrawerController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    _loadRole();
  }

  Future<void> _loadRole() async {
    try {
      final storedRole = await _authService.getUserRole();
      if (storedRole != null && storedRole.isNotEmpty) {
        role.value = storedRole.toLowerCase();
        // Set appropriate default tab for driver
        if (isDriver) {
          activeTab.value = NavTab.dashboard;
        }
      }
    } catch (e) {
      debugPrint('Failed to load role: $e');
    }
  }
}
