import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:apex/common/widgets/navigation/back_button_header.dart';
import '../../../../../common/widgets/navigation/custom_app_bar.dart';
import '../../../../core/core.dart';
import '../../../../data/models/driver_model.dart';
import '../controllers/drivers_list_controller.dart';

class DriversListView extends GetView<DriversListController> {
  const DriversListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color buttonBg = R.theme.cardBg;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: R.theme.darkBackground,
        appBar: CustomAppBar(title: 'Driver List'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.drivers.isEmpty) {
                      return const Center(
                        child: Text(
                          "No drivers available",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: controller.drivers.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final driver = controller.drivers[index];
                        return _buildDriverCard(
                          driver,
                          index,
                          R.theme.cardBg,
                          R.theme.secondary,
                          R.theme.white,
                          R.theme.grey,
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDriverCard(
    Driver driver,
    int index,
    Color cardBg,
    Color goldColor,
    Color textWhite,
    Color textGrey,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.grey[800],
                backgroundImage: AssetImage(driver.imagePath),
              ),

              16.sbw,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driver.name,
                      style: TextStyle(
                        color: textWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFD700),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          driver.rating.toString(),
                          style: TextStyle(
                            color: textGrey,
                            fontSize: 14,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    driver.arrivalTime,
                    style: TextStyle(
                      color: textWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    driver.distance,
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 14,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                ],
              ),
            ],
          ),

          6.sbh,
          const Divider(color: Colors.white12, thickness: 1),
          6.sbh,

          Text(
            driver.carModel.toUpperCase(),
            style: TextStyle(
              color: textGrey,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Urbanist',
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "\$${driver.price}",
            style: TextStyle(
              color: textWhite,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              fontFamily: 'Urbanist',
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              // Decline Button (Outlined)
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: OutlinedButton(
                    onPressed: () => controller.declineDriver(index),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: goldColor, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Decline",
                      style: TextStyle(
                        color: goldColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Accept Button (Filled)
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () => controller.acceptDriver(driver),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Accept",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
