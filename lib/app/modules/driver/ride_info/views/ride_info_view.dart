import 'package:apex/common/widgets/maps/map_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/ride_info_controller.dart';

class RideInfoView extends GetView<RideInfoController> {
  const RideInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_buildMap(), _buildHeader(), _buildDraggableSheet()],
      ),
    );
  }

  Widget _buildMap() {
    return Obx(
      () => MapComponent(
        mapController: controller.mapController,
        initialCenter: controller.pickupLocation,
        initialZoom: 13, // Lower zoom for overview of entire route
        tileLayerUrl:
            'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
        markers: controller.markers.toList(),
        interactionFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 40,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                // Open drawer or menu
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(16.0),
            child: _buildSheetContent(),
          ),
        );
      },
    );
  }

  Widget _buildSheetContent() {
    const textStyle = TextStyle(color: Colors.white);
    const boldStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    final detailStyle = TextStyle(color: Colors.grey[400], fontSize: 14);
    final valueStyle = const TextStyle(
      color: Color(0xFFC0A063),
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildRiderInfo(),
        const Divider(color: Colors.grey, height: 32),
        _buildTripInfoRow('PICK UP', '7958 Swift Village'),
        const Divider(color: Colors.grey, height: 32),
        _buildTripInfoRow('DROP OFF', '105 William St, Chicago, US'),
        const Divider(color: Colors.grey, height: 32),
        _buildFareDetails(detailStyle, valueStyle),
        const SizedBox(height: 24),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildRiderInfo() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
          radius: 24,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Esther Berry',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFC0A063),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'New',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC0A063),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Hide', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  Widget _buildTripInfoRow(String label, String address) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                address,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFareDetails(TextStyle detailStyle, TextStyle valueStyle) {
    return Column(
      children: [
        _buildFareRow('Price purposed', '\$ 120', detailStyle, valueStyle),
        const SizedBox(height: 12),
        _buildFareRow('Distance', '2.2 KM', detailStyle, valueStyle),
        const SizedBox(height: 12),
        _buildFareRow(
          'Estimated Time to Destination',
          '~20 Minutes',
          detailStyle,
          valueStyle,
        ),
        const SizedBox(height: 12),
        _buildFareRow('Base Fare', '\$ 20', detailStyle, valueStyle),
        const SizedBox(height: 12),
        _buildFareRow('Time Fare', '\$ 20', detailStyle, valueStyle),
      ],
    );
  }

  Widget _buildFareRow(
    String label,
    String value,
    TextStyle labelStyle,
    TextStyle valueStyle,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: labelStyle),
        Text(value, style: valueStyle),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFC0A063)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'Ignore',
              style: TextStyle(color: Color(0xFFC0A063), fontSize: 16),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _showStartRideDialog(Get.context!);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC0A063),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'Accept',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  void _showStartRideDialog(BuildContext context) {
    Get.dialog(
      Center(
        child: Container(
          width: 280,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Ready to start ride',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Have a safe journey !',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.toNamed(Routes.ACTIVE_RIDE);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC0A063),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Start Ride',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.45),
      barrierDismissible: false,
    );
  }
}
