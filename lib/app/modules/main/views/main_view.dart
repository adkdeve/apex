import 'package:apex/app/core/core.dart';
import 'package:apex/app/modules/shared/notifications/views/notifications_view.dart';
import 'package:apex/app/modules/shared/payment_method/views/payment_method_view.dart';
import 'package:apex/app/modules/shared/settings/views/privacy_policy.dart';
import 'package:apex/app/modules/shared/settings/views/terms_and_condition.dart';
import 'package:apex/common/widgets/build_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/my_text.dart';
import '../../../routes/app_pages.dart';
import '../../driver/completed_trips/views/completed_trip_view.dart';
import '../../driver/contact_us/views/contact_us_view.dart';
import '../../driver/dashboard/views/dashboard_view.dart';
import '../../driver/document_authentication/views/document_authentication_view.dart';
import '../../driver/maps/views/maps_view.dart';
import '../../driver/my_reviews/views/my_reviews_view.dart';
import '../../driver/schedules/views/schedules_view.dart';
import '../../driver/tools/views/tools_view.dart';
import '../../rider/home/views/home_view.dart';
import '../../rider/ride_history/views/ride_history_view.dart';
import '../../shared/profile/views/profile_view.dart';
import '../../shared/wallet/views/wallet_view.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  final String? selectedRole;

  const MainView({Key? key, this.selectedRole}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: AdvancedDrawer(
        backdropColor: R.theme.goldAccent,
        controller: controller.advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: false,
        openScale: 0.85,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        drawer: _buildDrawerContent(context),
        child: Scaffold(
          backgroundColor: R.theme.darkBackground,
          body: Stack(
            children: [
              // Content Area (full screen)
              Obx(() {
                final isDriver = controller.isDriver;

                if (isDriver) {
                  switch (controller.activeTab.value) {
                    case NavTab.dashboard:
                      return DashboardView();
                    case NavTab.maps:
                      return MapsView();
                    case NavTab.schedules:
                      return SchedulesView();
                    case NavTab.tools:
                      return ToolsView();
                    default:
                      return DashboardView();
                  }
                }

                // Rider content
                switch (controller.activeTab.value) {
                  case NavTab.home:
                    return HomeView();
                  case NavTab.wallet:
                    return WalletView();
                  case NavTab.history:
                    return RideHistoryView();
                  case NavTab.profile:
                    return ProfileView();
                  default:
                    return HomeView();
                }
              }),

              // Bottom Navigation Bar (overlayed at bottom)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildCustomNavBar(controller),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerContent(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Obx(() {
          final isDriver = controller.isDriver;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.sbh,
              _buildDrawerButton("Account Information", R.theme.darkBackground, () {
                try {
                  controller.advancedDrawerController.hideDrawer();
                } catch (e) {}
                if (isDriver) {
                  controller.advancedDrawerController.hideDrawer();
                  Get.toNamed(Routes.PROFILE);
                } else {
                  controller.changeTab(NavTab.profile);
                }
              }),
              16.sbh,
              _buildDrawerButton(
                isDriver ? "Documents" : "Payment Method",
                R.theme.darkBackground,
                () => isDriver
                    ? Get.to(() => VerificationView())
                    : Get.to(() => const PaymentMethodView()),
              ),
              if (isDriver) ...[
                16.sbh,
                _buildDrawerButton("My Reviews", R.theme.darkBackground, () {
                  controller.advancedDrawerController.hideDrawer();
                  Get.to(() => MyReviewsView());
                }),
              ],
              16.sbh,
              _buildDrawerButton(
                "Notifications",
                R.theme.darkBackground,
                () {
                  controller.advancedDrawerController.hideDrawer();
                  Get.to(NotificationsView());
                  },
              ),
              16.sbh,
              _buildDrawerButton(
                isDriver ? "Ride History" : "Wallet",
                R.theme.darkBackground,
                () {
                  if (isDriver) {
                    controller.advancedDrawerController.hideDrawer();
                    Get.to(() => CompletedTripsView());
                  } else {
                    try {
                      controller.advancedDrawerController.hideDrawer();
                    } catch (e) {
                    }
                    controller.changeTab(NavTab.wallet);
                  }
                },
              ),
              40.sbh,
              Divider(color: Colors.white.withOpacity(0.4), thickness: 1),
              20.sbh,
              _buildTextLink(
                "Privacy Policy",
                () {
                  controller.advancedDrawerController.hideDrawer();
                  Get.to(() => const PrivacyPolicyView());
                  },
              ),
              12.sbh,
              _buildTextLink(
                "Terms & Conditions",
                () {
                  controller.advancedDrawerController.hideDrawer();
                  Get.to(() => const TermsAndConditionView());
                  },
              ),
              if (isDriver) ...[
                12.sbh,
                _buildTextLink(
                  "Contact Us",
                  () {
                    controller.advancedDrawerController.hideDrawer();
                    Get.to(() => const ContactUsView());
                    },
                ),
              ],
              20.sbh,
              Divider(color: Colors.white.withOpacity(0.4), thickness: 1),
              30.sbh,
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.ONBOARDING);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                      size: 22,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildDrawerButton(String title, Color bgColor, VoidCallback onTap) {
    return SizedBox(
      width: 200, // Limit width so it doesn't span full drawer width
      height: 42,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.centerLeft, // Align text to left
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: 'Urbanist',
          ),
        ),
      ),
    );
  }

  Widget _buildTextLink(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Urbanist',
        ),
      ),
    );
  }

  Widget _buildCustomNavBar(MainController controller) {
    return Container(
      // constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: R.theme.cardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Obx(() {
        final isDriver = controller.isDriver;

        if (isDriver) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavBarItem(
                isSelected: controller.activeTab.value == NavTab.dashboard,
                label: "Dashboard",
                onTap: () => controller.changeTab(NavTab.dashboard),
                svgAsset: 'assets/icons/ic_home.svg',
              ),
              _NavBarItem(
                isSelected: controller.activeTab.value == NavTab.maps,
                label: "Maps",
                onTap: () => controller.changeTab(NavTab.maps),
                svgAsset: 'assets/icons/ic_map.svg',
              ),
              _NavBarItem(
                isSelected: controller.activeTab.value == NavTab.schedules,
                label: "Schedules",
                onTap: () => controller.changeTab(NavTab.schedules),
                svgAsset: 'assets/icons/ic_schedule.svg',
              ),
              _NavBarItem(
                isSelected: controller.activeTab.value == NavTab.tools,
                label: "Tools",
                onTap: () => controller.changeTab(NavTab.tools),
                svgAsset: 'assets/icons/ic_tools.svg',
              ),
            ],
          );
        }

        // Rider nav bar
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavBarItem(
              isSelected: controller.activeTab.value == NavTab.home,
              label: "Home",
              onTap: () => controller.changeTab(NavTab.home),
              svgAsset: 'assets/icons/ic_home.svg',
            ),
            _NavBarItem(
              isSelected: controller.activeTab.value == NavTab.wallet,
              label: "Wallet",
              onTap: () => controller.changeTab(NavTab.wallet),
              svgAsset: 'assets/icons/ic_wallet.svg',
            ),
            _NavBarItem(
              isSelected: controller.activeTab.value == NavTab.history,
              label: "Ride History",
              onTap: () => controller.changeTab(NavTab.history),
              svgAsset: 'assets/icons/ic_history.svg',
            ),
            _NavBarItem(
              isSelected: controller.activeTab.value == NavTab.profile,
              label: "Profile",
              onTap: () => controller.changeTab(NavTab.profile),
              svgAsset: 'assets/icons/ic_profile.svg',
            ),
          ],
        );
      }),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final bool isSelected;
  final String label;
  final VoidCallback onTap;
  final String svgAsset;

  const _NavBarItem({
    required this.isSelected,
    required this.label,
    required this.onTap,
    required this.svgAsset,
  });

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFFC8A74E);
    const inactiveIconColor = Color(0xFF9DB2CE);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildImage(
              svgAsset,
              width: 21,
              height: 21,
              color: isSelected ? Colors.white : inactiveIconColor,
              context: context,
            ),
            if (isSelected) ...[
              5.sbw,
              MyText(
                text: label,
                color: Colors.white,
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
