import 'package:apex/app/core/core.dart';
import 'package:apex/app/modules/driver/shared/widgets/driver_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/requests_controller.dart';

class RequestsView extends StatelessWidget {
  final RequestsController controller = Get.put(RequestsController());

  RequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DriverHeader(
                title: "Requests",
                onBackPressed: controller.goBack,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: controller.filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return Obx(() {
                    bool isSelected =
                        controller.selectedFilterIndex.value == index;
                    return GestureDetector(
                      onTap: () => controller.changeFilter(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? R.theme.goldAccent
                              : const Color(0xFF252525),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            controller.filters[index],
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                clipBehavior:
                    Clip.antiAlias, // Ensures the header respects border radius
                decoration: BoxDecoration(
                  color: R.theme.cardBgVariant,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      color: R.theme.goldAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            controller.requestData['type'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      controller.requestData['passengerImage']
                                          as String,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    controller.requestData['passengerName']
                                        as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              OutlinedButton(
                                onPressed: controller.onViewProfile,
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: R.theme.goldAccent),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 0,
                                  ),
                                ),
                                child: const Text(
                                  "View",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            color: R.theme.driverBorderColor,
                            thickness: 1,
                          ),
                          const SizedBox(height: 16),

                          Text(
                            "PICK UP",
                            style: TextStyle(
                              color: R.theme.driverGreyText,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            controller.requestData['pickupAddress'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            color: R.theme.driverBorderColor,
                            thickness: 1,
                          ),
                          const SizedBox(height: 16),

                          _buildDetailRow(
                            "Pickup Date",
                            controller.requestData['pickupDate'] as String,
                          ),
                          _buildDetailRow(
                            "Pickup Time",
                            controller.requestData['pickupTime'] as String,
                          ),
                          _buildDetailRow(
                            "Hourly Rate",
                            controller.requestData['hourlyRate'] as String,
                          ),
                          _buildDetailRow(
                            "Booked hours",
                            controller.requestData['bookedHours'] as String,
                          ),

                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Estimated total",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                controller.requestData['estimatedTotal']
                                    as String,
                                style: TextStyle(
                                  color: R.theme.goldAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: controller.onIgnore,
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: R.theme.goldAccent),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                  ),
                                  child: Text(
                                    "Ignore",
                                    style: TextStyle(
                                      color: R.theme.goldAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: controller.onAccept,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: R.theme.goldAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                  ),
                                  child: const Text(
                                    "Accept",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: R.theme.driverGreyText, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(
              color: R.theme.goldAccent,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
