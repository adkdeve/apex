import 'package:apex/app/core/core.dart';
import 'package:apex/utils/helpers/snackbar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ---------------------------------------------
// 1. CONTROLLER
// ---------------------------------------------
class ReusableCameraController extends GetxController {
  CameraController? cameraController;
  var isCameraInitialized = false.obs;
  List<CameraDescription> cameras = [];

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        // Use the first back camera
        final backCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back,
          orElse: () => cameras.first,
        );

        cameraController = CameraController(
          backCamera,
          ResolutionPreset.high,
          enableAudio: false,
        );

        await cameraController!.initialize();
        isCameraInitialized.value = true;
      } else {
        SnackBarUtils.errorMsg("No camera found on device");
      }
    } catch (e) {
      SnackBarUtils.errorMsg("Failed to initialize camera: $e");
    }
  }

  Future<void> takePicture() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return;
    }

    try {
      final XFile file = await cameraController!.takePicture();
      // Return the image path to the previous screen
      Get.back(result: file.path);
    } on CameraException catch (e) {
      SnackBarUtils.errorMsg("Failed to capture image: ${e.description}");
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}

// ---------------------------------------------
// 2. VIEW (Reusable Widget)
// ---------------------------------------------
class ReusableCameraView extends StatelessWidget {
  // The title displayed above the camera frame
  final String title;

  // Dependency Injection
  final ReusableCameraController controller = Get.put(
    ReusableCameraController(),
  );

  ReusableCameraView({
    Key? key,
    this.title =
        "Position the front of your passport size image", // Default title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.theme.driverGreyBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // --- Top Bar ---
            Positioned(
              top: 10,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      "Back",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement help logic
                    },
                    child: const Text(
                      "Get help",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            // --- Main Content ---
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),

                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // --- Camera Viewport ---
                // This white container creates the frame.
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  height: 240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  // ClipRRect is used to clip the CameraPreview to the rounded container
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Obx(() {
                      if (controller.isCameraInitialized.value) {
                        // Display camera feed
                        return AspectRatio(
                          aspectRatio:
                              controller.cameraController!.value.aspectRatio,
                          child: CameraPreview(controller.cameraController!),
                        );
                      } else {
                        // Loading indicator while initializing
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        );
                      }
                    }),
                  ),
                ),

                const Spacer(),

                // --- Capture Button ---
                GestureDetector(
                  onTap: controller.takePicture,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    // Inner grey ring for styling
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
