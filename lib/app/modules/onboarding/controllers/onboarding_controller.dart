import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/onboarding_model.dart';
import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  // Observable state for the current index
  var currentSlideIndex = 0.obs;

  // PageController for handling swipe animations (standard mobile UX)
  final PageController pageController = PageController();

  // The Data
  final List<OnboardingSlide> slides = [
    OnboardingSlide(
      image: 'assets/images/onboarding_image_1.png',
      title: 'Choose the Right Protection for Every Moment',
      description: 'Select from a range of skilled, verified bodyguards, personalized to your comfort, lifestyle, and security needs.',
    ),
    OnboardingSlide(
      image: 'assets/images/onboarding_image_2.png',
      title: 'Stay Safe and Confident Wherever You Go',
      description: 'From daily commutes to special events, book trusted professionals who ensure your peace of mind every step of the way.',
    ),
  ];

  // Logic to update index when page is swiped
  void onPageChanged(int index) {
    currentSlideIndex.value = index;
  }

  // Logic for the "Next" button
  void handleNext() {
    if (currentSlideIndex.value < slides.length - 1) {
      // Move to next slide
      pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut
      );
    } else {
      // Trigger completion
      _onComplete();
    }
  }

  void _onComplete() {
    Get.offAllNamed(Routes.ROLESELECTION);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}