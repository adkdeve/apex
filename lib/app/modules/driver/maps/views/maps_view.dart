import 'package:apex/app/modules/driver/maps/views/ride_request_list_view.dart';
import 'package:apex/app/modules/main/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import '../controllers/maps_controller.dart';

class MapsView extends StatelessWidget {
  MapsView({super.key});

  final MapsController controller = Get.put(MapsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => Stack(
          children: [
            // Google Map
            _buildMap(),

            // Top Status Bar
            _buildTopBar(),

            // Online/Offline Banner (shows for 3 seconds after status change)
            if (controller.showStatusBanner.value) _buildStatusBanner(),

            // Ride Requests Overlay (if visible)
            if (controller.showRideRequests.value) const RideRequestListView(),

            // Compass/Navigation Button
            // Positioned(
            //   bottom: 120,
            //   right: 16,
            //   child: _buildShowRequestsButton(),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: controller.mapController,
      options: MapOptions(
        initialCenter: controller.currentLocation.value,
        initialZoom: 15,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'com.devitcity.apex',
        ),
        if (controller.circles.isNotEmpty)
          CircleLayer(circles: controller.circles),
        if (controller.markers.isNotEmpty)
          MarkerLayer(markers: controller.markers),
      ],
    );
  }

  Widget _buildTopBar() {
    final mainController = MainController();
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.only(
          top: 50,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withOpacity(0.3), Colors.transparent],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Menu Icon
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
            // Online/Offline Status Text
            Text(
              controller.isOnline.value ? 'Online' : 'Offline',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Toggle Switch
            GestureDetector(
              onTap: controller.toggleOnlineStatus,
              child: Container(
                width: 54,
                height: 32,
                decoration: BoxDecoration(
                  color: controller.isOnline.value
                      ? const Color(0xFF4CAF50)
                      : Colors.grey[700],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: controller.isOnline.value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 28,
                    height: 28,
                    margin: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBanner() {
    return Positioned(
      top: 120,
      left: 16,
      right: 16,
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: controller.isOnline.value
                ? const Color(0xFF4CAF50)
                : Colors.redAccent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                controller.isOnline.value
                    ? Icons.wifi_tethering_rounded
                    : Icons.wifi_tethering_off_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Text(
                'You are now ${controller.isOnline.value ? 'Online' : 'Offline'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
