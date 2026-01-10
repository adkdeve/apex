import 'package:apex/app/modules/shared/notifications/views/notifications_view.dart';
import 'package:apex/common/widgets/build_image.dart';
import 'package:apex/common/widgets/ride/fare_breakdown_row.dart';
import 'package:apex/common/widgets/ride/route_display_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../core/core.dart';
import '../../../../routes/app_pages.dart';
import '../../../main/controllers/main_controller.dart';
import '../../hourly_reservation/views/hourly_reservation_view.dart';
import '../../point_to_point/views/point_to_point_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: R.theme.darkBackground,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),

                24.sbh,

                const Text(
                  "Select Type of Ride",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Urbanist',
                  ),
                ),

                12.sbh,

                Column(
                  children: [
                    _buildRideTypeCard(
                      id: 'point-to-point',
                      title: "Point to point",
                      subtitle: "Regular ride type",
                      image: 'assets/images/point_to_point.png',
                      context: context,
                      onTap: () {
                        Get.toNamed(Routes.POINT_TO_POINT);
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildRideTypeCard(
                      id: 'airport',
                      title: "Airport pickup/ drop-off",
                      subtitle: "Airport has additional fees due to permits",
                      image: 'assets/images/airport_pickup.png',
                      context: context,
                      onTap: () {},
                    ),
                    const SizedBox(height: 8),
                    _buildRideTypeCard(
                      id: 'hourly',
                      title: "Hourly reservations",
                      subtitle: "This will give an hourly rate (min 2 hours)",
                      image: 'assets/images/hourly_reservation.png',
                      context: context,
                      onTap: () {
                        Get.toNamed(Routes.HOURLY_RESERVATION);
                      },
                    ),
                  ],
                ),

                24.sbh,

                const Text(
                  "Schedules",
                  style: TextStyle(
                    color: Color(0xFFFCFCFC),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),

                12.sbh,

                _buildActiveScheduleCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final mainController = Get.find<MainController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            // Safely access MainController with error handling
            try {
              mainController.toggleDrawer();
            } catch (e) {
              // Controller not found or disposed, ignore the tap
              debugPrint('MainController not available: $e');
            }
          },
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.menu, color: Color(0xFF242424)),
          ),
        ),

        Obx(
          () => Text(
            "Hello ${mainController.userName.value}!",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ),

        GestureDetector(
          onTap: () => Get.to(NotificationsView()),
          child: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_active,
              color: Color(0xFF242424),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRideTypeCard({
    required String id,
    required String title,
    required String subtitle,
    required String image,
    required BuildContext context,
    required VoidCallback onTap,
  }) {
    return Obx(() {
      bool isSelected = controller.selectedRideType.value == id;
      Color bgColor = const Color(0xFF2C2C2E);
      Color borderColor = isSelected
          ? const Color(0xFFC8A74E)
          : Colors.transparent;

      return GestureDetector(
        onTap: () {
          controller.selectRideType(id);
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: buildImage(image, fit: BoxFit.cover, context: context),
                ),
              ),

              16.sbw,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                      ),
                    ),

                    6.sbh,

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFFD1D1D6),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.3,
                        fontFamily: 'Urbanist',
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildActiveScheduleCard() {
    final Color textGrey = R.theme.textGrey;
    const Color dividerColor = Colors.white10;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: R.theme.cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  "https://i.pinimg.com/736x/97/3c/fc/973cfcca079333c9657855db38bdc79f.jpg",
                ),
              ),

              12.sbw,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ben Stokes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    2.sbh,

                    Row(
                      children: [
                        Icon(Icons.star, color: Color(0xFFFFC107), size: 14),

                        2.sbw,

                        Text(
                          "4.9",
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),

                    2.sbh,

                    const Text(
                      "Suzuki Alto",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 35,
                    width: 70,
                    child: Image.network(
                      "https://www.pngmart.com/files/4/Car-PNG-HD.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  4.sbh,

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "APT 238",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          6.sbh,

          const Divider(color: dividerColor, thickness: 1),

          RouteDisplaySection(
            pickupLocation: "Current location",
            pickupSubtitle: "2972 Westheimer Rd. Santa Ana, Illinois 85486",
            dropoffLocation: "Airport",
            dropoffSubtitle: "1901 Thornridge Cir. Shiloh, Hawaii 81063",
            distance: "1.1km",
            pickupColor: const Color(0xFFF44336),
            dropoffColor: const Color(0xFFFFC107),
          ),

          const Divider(color: dividerColor, thickness: 1),

          6.sbh,

          FareBreakdownRow(
            label: "Travel time",
            value: "~44min.",
            labelColor: textGrey,
            valueColor: R.theme.secondary,
          ),
          FareBreakdownRow(
            label: "Base fare",
            value: "\$9,00",
            labelColor: textGrey,
            valueColor: R.theme.secondary,
          ),
          FareBreakdownRow(
            label: "Distance fare",
            value: "\$9,00",
            labelColor: textGrey,
            valueColor: R.theme.secondary,
          ),
          FareBreakdownRow(
            label: "Time fare",
            value: "\$9,00",
            labelColor: textGrey,
            valueColor: R.theme.secondary,
          ),

          6.sbh,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Estimate",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Text(
                "\$20,00",
                style: TextStyle(
                  color: R.theme.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          6.sbh,

          const Divider(color: dividerColor, thickness: 1),

          6.sbh,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                      size: 18,
                    ),

                    8.sbw,

                    Flexible(
                      child: Text(
                        "8:00-9:00 AM, 09 Dec",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              Builder(
                builder: (context) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final buttonWidth = screenWidth * 0.32;
                  final buttonHeight = screenWidth < 400 ? 36.0 : 44.0;
                  return SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: controller.onCancelRide,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: R.theme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth < 400 ? 12 : 24,
                        ),
                      ),
                      child: const Text(
                        "Cancel Ride",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
