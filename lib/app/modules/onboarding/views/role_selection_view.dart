import 'package:apex/app/core/core.dart';
import 'package:apex/common/widgets/build_image.dart';
import 'package:apex/common/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/role_selection_controller.dart';

class RoleSelectionView extends GetView<RoleSelectionController> {
  const RoleSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: buildImage(
                'assets/images/role_selection.png',
                fit: BoxFit.cover,
                context: context,
              ),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                    ],
                    stops: const [0.0, 0.5, 1.0], // Approximate stop points for "via"
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 64, top: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Heading
                    MyText(
                      text: "Welcome",
                      textAlign: TextAlign.center,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),

                    18.sbh,

                    // Subtext
                    MyText(
                      text: "Tell us who you are to get you started",
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      color: Colors.grey[300],
                    ),

                    53.sbh,

                    // Buttons Container
                    Column(
                      children: [
                        // "I'm a Rider" Button (Solid Gold)
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () => controller.selectRole('rider'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: R.theme.secondary,
                              foregroundColor: R.theme.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: MyText(
                              text: "I'm a Rider",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                            ),
                          ),
                        ),

                        12.sbh,

                        // "I'm a Driver" Button (Outlined Gold)
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: OutlinedButton(
                            onPressed: () => controller.selectRole('driver'),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              side: BorderSide(color: R.theme.secondary, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: MyText(
                              text: "I'm a Driver",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: R.theme.secondary
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