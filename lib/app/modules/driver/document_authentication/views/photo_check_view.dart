import 'package:apex/app/core/core.dart';
import 'package:apex/app/data/models/photo_model.dart';
import 'package:apex/app/modules/driver/document_authentication/views/setup_vehicle_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ---------------------------------------------
// 1. CONTROLLER
// ---------------------------------------------
class PhotoCheckController extends GetxController {
  // Reactive variable to hold the photo data.
  // In a real app, this would be populated with the image path from the camera.
  final photo = PhotoModel(imagePath: null).obs;

  void takeNewPicture() {
    // TODO: Implement logic to open the camera and capture a new picture.
    print("Take a new picture Clicked");
  }

  void next() {
    Get.to(() => SetupVehicleView());
  }
}

// ---------------------------------------------
// 3. VIEW
// ---------------------------------------------
class PhotoCheckView extends StatelessWidget {
  // Dependency Injection: Put the controller into memory.
  final PhotoCheckController controller = Get.put(PhotoCheckController());

  PhotoCheckView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.theme.black,
      appBar: AppBar(
        backgroundColor: R.theme.black,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: R.theme.driverButtonBg,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.white,
              ),
              onPressed: () => Get.back(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // --- Image Frame ---
              _buildImageFrame(),

              const SizedBox(height: 32),

              // --- Title ---
              const Text(
                "Is the photo readable?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // --- Description ---
              Text(
                "Please make sure your card is close to the frame and all the text is clear.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                  height: 1.4,
                ),
              ),

              const Spacer(),

              // --- Bottom Buttons ---
              _buildBottomButtons(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageFrame() {
    return Container(
      height: 320,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: R.theme.driverFrameColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Obx(() {
        // Display the image if path is available, otherwise a placeholder.
        if (controller.photo.value.imagePath != null) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            // Replace with Image.file() for a local file
            child: Image.network(
              controller.photo.value.imagePath!,
              fit: BoxFit.cover,
            ),
          );
        } else {
          // Placeholder when no image is selected
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.person, size: 80, color: Colors.grey),
            ),
          );
        }
      }),
    );
  }

  Widget _buildBottomButtons() {
    return Column(
      children: [
        // "Take a new picture" Button (Outlined)
        OutlinedButton(
          onPressed: controller.takeNewPicture,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: R.theme.goldAccent, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 18),
            minimumSize: const Size(double.infinity, 0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Take a new picture",
                style: TextStyle(
                  color: R.theme.goldAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.camera_alt_outlined, color: R.theme.goldAccent),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // "Next" Button (Solid)
        ElevatedButton(
          onPressed: controller.next,
          style: ElevatedButton.styleFrom(
            backgroundColor: R.theme.goldAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 18),
            minimumSize: const Size(double.infinity, 0),
            elevation: 0,
          ),
          child: const Text(
            "Next",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

