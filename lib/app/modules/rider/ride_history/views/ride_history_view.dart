import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/rental_ride_card.dart';
import '../../../../core/core.dart';
import '../../../../data/models/ride_history_model.dart';
import '../controllers/ride_history_controller.dart';

class RideHistoryView extends GetView<RideHistoryController> {
  RideHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: R.theme.darkBackground,
        title: Text(
          "Ride History",
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
            _buildFilterSection(),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                return ListView.builder(
                  // FIXED: Added specific bottom padding to clear the navbar
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 100, // Extra padding ensures last item isn't covered
                  ),
                  itemCount: controller.historyItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.historyItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: item.type == RideType.standard
                          ? _buildStandardRideCard(item)
                          : RentalRideCard(item: item),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "History",
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: R.theme.secondary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Obx(
                      () => Text(
                    controller.currentFilter.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                5.sbw,

                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStandardRideCard(RideHistoryModel item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: R.theme.cardBgVariant,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // --- Top Section: Route & Time ---
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Timeline Graphic (Icons + Line)
                Column(
                  children: [
                    // Start Icon: Hollow Red Circle
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE53935),
                          width: 4,
                        ),
                      ),
                    ),

                    // CustomPaint inside Expanded
                    Expanded(
                      child: SizedBox(
                        width: 2,
                        child: CustomPaint(
                          painter: DashedLineVerticalPainter(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),

                    // End Icon: Green Pin
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFF00C853),
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(width: 16),

                // 2. Text Content (Locations & Times)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Pickup Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.pickupLocation,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item.pickupTime,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28), // Vertical gap
                      // Dropoff Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.dropLocation ?? "Home",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item.dropTime ?? "",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24), // Gap between Route and Driver info
          // --- Bottom Section: Driver Info ---
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(item.imageUrl),
              ),
              const SizedBox(width: 12),

              // Name & Rating
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.driverName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFC107),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.rating.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),

              // Price Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Price",
                    style: TextStyle(color: Color(0xFF757575), fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${item.price}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  final Color color;
  DashedLineVerticalPainter({this.color = Colors.grey});

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 4, dashSpace = 4, startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}