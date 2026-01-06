import 'package:apex/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/schedule_card.dart';
import '../controllers/schedules_controller.dart';

class SchedulesView extends GetView<SchedulesController> {
  const SchedulesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SchedulesController());
    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: R.theme.darkBackground,
        title: const Text(
          "Schedules",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.schedules.isEmpty) {
            return const Center(
              child: Text("No schedules found", style: TextStyle(color: Colors.white)),
            );
          }

          return ListView.separated(
            // FIXED: Changed symmetric vertical padding to specific top/bottom padding
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 100, // <--- Add extra padding here (e.g., 100 or 120) to clear the nav bar
            ),
            itemCount: controller.schedules.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final item = controller.schedules[index];
              return ScheduleCard(
                data: item,
                onStartRide: () {
                  controller.startRide(item);
                },
              );
            },
          );
        }),
      ),
    );
  }
}