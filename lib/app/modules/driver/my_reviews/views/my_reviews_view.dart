import 'package:apex/app/modules/driver/my_reviews/controllers/my_reviews_controller.dart';
import 'package:apex/app/modules/driver/shared/widgets/driver_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/review_item.dart';
import '../../../../core/core.dart';

class MyReviewsView extends GetView<MyReviewsController> {
  MyReviewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MyReviewsController());

    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // --- Header ---
              _buildHeader(),

              const SizedBox(height: 20),

              // --- Review List ---
              Expanded(
                child: Obx(() {
                  return ListView.separated(
                    itemCount: controller.reviews.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 24),
                    itemBuilder: (context, index) {
                      return ReviewItem(review: controller.reviews[index]);
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

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: DriverBackButton(onPressed: () => Get.back()),
        ),

        const Text(
          "My Reviews",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
