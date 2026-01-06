import 'package:apex/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tools_controller.dart';

class ToolsView extends StatelessWidget {
  final ToolsController controller = Get.put(ToolsController());

  ToolsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. Get screen width to calculate responsive font sizes
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth < 380;

    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: R.theme.darkBackground,
        title: const Text(
          "Driver Tools",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "Quick tools to manage your\nvehicle and trips",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: R.theme.driverGreyText,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                // Adjust ratio slightly based on screen size
                childAspectRatio: isSmallScreen ? 0.7 : 0.75,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 100),
                children: [
                  _buildToolCard(
                    icon: Icons.local_gas_station_rounded,
                    title: "Fuel Log",
                    description: "Add fuel receipt, vendor, gallons, cost",
                    buttonText: "Add Fuel Log",
                    onTap: controller.onAddFuelLog,
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildToolCard(
                    icon: Icons.directions_car_rounded,
                    title: "Vehicle Checklist",
                    description: "Complete daily inspection",
                    buttonText: "Start Checklist",
                    onTap: controller.onStartChecklist,
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildToolCard(
                    icon: Icons.report_problem_rounded,
                    title: "Incident Report",
                    description: "Report issues with photos",
                    buttonText: "Submit Report",
                    onTap: controller.onSubmitIncident,
                    isSmallScreen: isSmallScreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolCard({
    required IconData icon,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onTap,
    required bool isSmallScreen,
  }) {
    // Define responsive sizes
    final double titleSize = isSmallScreen ? 14 : 16;
    final double descSize = isSmallScreen ? 11 : 12;
    final double buttonTextSize = isSmallScreen ? 10 : 12;
    final double iconSize = isSmallScreen ? 20 : 24;
    final double iconBgSize = isSmallScreen ? 40 : 48;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: R.theme.cardBgVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Top Section ---
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: iconBgSize,
                height: iconBgSize,
                decoration: BoxDecoration(
                  color: R.theme.goldAccent,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: iconSize),
              ),
              const SizedBox(height: 12),

              // FittedBox ensures Title scales down if it's still too wide
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // --- Description ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  description,
                  style: TextStyle(
                    color: R.theme.driverGreyText,
                    fontSize: descSize,
                    height: 1.3,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),

          // --- Button ---
          SizedBox(
            width: double.infinity,
            height: isSmallScreen ? 32 : 36,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: R.theme.goldAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                elevation: 0,
              ),
              // FittedBox ensures button text scales down to fit the button width
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: buttonTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}