import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/maps_controller.dart';
import '../widgets/ride_request_card.dart';

class RideRequestListView extends GetView<MapsController> {
  const RideRequestListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            controller.showRideRequests.value = false;
          },
        ),
        title: const Text(
          'Ride Requests',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(
            () => ListView.separated(
          // 1. Add specific padding. bottom: 120 ensures the last item
          // clears the navbar (which is usually 60-80px + safe area).
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: 100.0,
          ),
          itemCount: controller.rideRequests.length,
          // 2. Add spacing between cards
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final request = controller.rideRequests[index];
            return RideRequestCard(request: request);
          },
        ),
      ),
    );
  }
}