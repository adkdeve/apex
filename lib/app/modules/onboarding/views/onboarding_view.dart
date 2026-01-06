import 'package:apex/app/core/core.dart';
import 'package:apex/common/widgets/build_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/my_text.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: Get.height * 0.75,
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.slides.length,
                itemBuilder: (context, index) {
                  return buildImage(
                    controller.slides[index].image,
                    fit: BoxFit.cover,
                    context: context,
                  );
                },
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: Get.height * 0.756,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 63, top: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Obx(() => MyText(
                      text: controller.slides[controller.currentSlideIndex.value].title,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    )),

                    16.sbh,

                    // Description + Arrow Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Description (takes remaining space)
                        Expanded(
                          child: Obx(() => MyText(
                            text: controller.slides[controller.currentSlideIndex.value].description,
                              fontSize: 14,
                              color: Colors.grey[300],
                              height: 1.5,
                            softWrap: true,
                            textAlign: TextAlign.start,
                          )),

                        ),

                        16.sbw,

                        // Arrow Button (fixed size)
                        GestureDetector(
                          onTap: controller.handleNext,
                          child: Container(
                            width: 48,
                            height: 48,
                            child: Center(
                              child: buildImage(
                                'assets/icons/forward_arrow.svg',
                                width: 40,
                                height: 40,
                                context: context,
                              ),
                            ),
                          ),
                        ),
                      ],
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
}