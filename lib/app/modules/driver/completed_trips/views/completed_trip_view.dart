import 'package:apex/app/modules/driver/shared/widgets/driver_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/trip_card.dart';
import '../../../../core/core.dart';
import '../controllers/completed_trips_controller.dart';

class CompletedTripsView extends GetView<CompletedTripsController> {
  CompletedTripsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CompletedTripsController());
    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DriverBackButton(onPressed: () => Get.back()),
                  const Text(
                    "Completed Trips",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 40), // Balance spacing
                ],
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "History",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildFilterButton(),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Obx(() {
                  return ListView.separated(
                    itemCount: controller.completedTrips.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return TripCard(trip: controller.completedTrips[index]);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: R.theme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Obx(
        () => Row(
          children: [
            Text(
              controller.selectedFilter.value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
