import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/activity_log.dart';
import '../../../main/controllers/main_controller.dart';
import '../../../shared/notifications/views/notifications_view.dart';
import '../../requests/views/requests_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);

  static const Color kBgColor = Color(0xFF111111);
  static const Color kCardColor = Color(0xFF1E1E1E);
  static const Color kGoldColor = Color(0xFFEBC27E);
  static const Color kTextGrey = Color(0xFF9E9E9E);

  static const Color kGreen = Color(0xFF6FCF97);
  static const Color kRed = Color(0xFFEB5757);
  static const Color kOrange = Color(0xFFF2994A);
  static const Color kBlue = Color(0xFF2F80ED);

  @override
  Widget build(BuildContext context) {

    Get.put(DashboardController());

    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),

              const SizedBox(height: 24),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      _buildHourlyRidesCard(),
                      const SizedBox(height: 16),
                      _buildOnShiftCard(),
                      const SizedBox(height: 16),
                      _buildActionGrid(),
                      const SizedBox(height: 16),
                      _buildTargetCard(),
                      const SizedBox(height: 16),
                      _buildOvertimeCounter(),
                    ],
                  ),
                ),
              ),
            ],
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

  Widget _buildHourlyRidesCard() {
    return GestureDetector(
      onTap: () => Get.to(() => RequestsView()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.access_time_filled,
                  color: kGoldColor,
                  size: 24,
                ),
                const SizedBox(width: 14),
                const Text(
                  "Hourly Rides",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              "2 Jobs",
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnShiftCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: kGreen,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "On Shift",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow("Worked Hours Today", controller.workedHours.value),
          const SizedBox(height: 12),
          _buildInfoRow("Remaining Hours", controller.remainingHours.value),
          const SizedBox(height: 12),
          _buildInfoRow("Overtime", "${controller.overtime.value}h"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
            label,
            style: const TextStyle(color: kTextGrey, fontSize: 14, fontWeight: FontWeight.w400)
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildActionGrid() {
    // Custom internal widget to match the specific look of the buttons in the image
    // if ActionButton from your imports doesn't support custom colors perfectly.
    Widget buildBtn(String label, IconData icon, Color iconColor) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: buildBtn("Clock In", Icons.schedule, kGreen)),
            const SizedBox(width: 12),
            Expanded(child: buildBtn("Clock Out", Icons.stop_circle_outlined, kRed)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: buildBtn("Start Break", Icons.pause_circle_filled, kOrange)),
            const SizedBox(width: 12),
            Expanded(child: buildBtn("End Break", Icons.play_circle_fill, kBlue)),
          ],
        ),
      ],
    );
  }

  Widget _buildTargetCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daily Hour Target",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: controller.dailyProgress.value,
              minHeight: 6,
              backgroundColor: const Color(0xFF333333),
              valueColor: const AlwaysStoppedAnimation<Color>(kGreen),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "${controller.workedHours.value} worked • ${controller.remainingHours.value} left",
            style: const TextStyle(color: kTextGrey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildOvertimeCounter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_fire_department_rounded,
                color: kGoldColor, // Using Gold/Orange from image
                size: 26,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Overtime Counter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "2 hrs overtime worked this week",
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Directly using the list from controller
          ...controller.logs.map((log) => _buildLogItem(log)).toList(),
        ],
      ),
    );
  }

  Widget _buildLogItem(ActivityLog log) {
    IconData getIcon() {
      switch (log.icon) {
        case 'clock_in': return Icons.schedule;
        case 'clock_out': return Icons.stop_circle_outlined;
        case 'pause': return Icons.pause_circle_filled;
        case 'play': return Icons.play_circle_fill;
        default: return Icons.circle;
      }
    }

    // Manual mapping for the specific colors in the image if not in model
    Color getColor() {
      switch (log.icon) {
        case 'clock_in': return kGreen;
        case 'clock_out': return kRed;
        case 'pause': return kOrange;
        case 'play': return kBlue;
        default: return Colors.grey;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(getIcon(), color: getColor(), size: 20),
              const SizedBox(width: 14),
              Text(
                log.title, // e.g., "Clock In"
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Text(
            log.time, // e.g., "9:00 AM"
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}