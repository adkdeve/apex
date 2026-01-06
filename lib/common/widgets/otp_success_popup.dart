import 'dart:ui';
import 'package:apex/app/core/core.dart';
import 'package:apex/common/widgets/build_image.dart';
import 'package:flutter/material.dart';
import 'my_text.dart';

class VerificationSuccessPopup extends StatelessWidget {
  final VoidCallback onDone;

  const VerificationSuccessPopup({Key? key, required this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. Wrap in PopScope to prevent Android Back Button dismissal
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 340),
          decoration: BoxDecoration(
            // Suggestion: Move this color to R.theme.surface or similar
            color: const Color(0xFF0B0B0C),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(24),
          // 2. Wrap in SingleChildScrollView to prevent overflow on small landscape screens
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 171,
                  height: 151,
                  child: buildImage(
                    'assets/icons/ic_success.svg',
                    context: context,
                  ),
                ),
                16.sbh,
                MyText(
                  text: "Verification Complete!",
                  textAlign: TextAlign.center,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                9.sbh,
                MyText(
                  text: "Thanks for your patience. Enjoy all features of the app",
                  textAlign: TextAlign.center,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  // Suggestion: Move this color to R.theme.subtext
                  color: const Color(0xFF767676),
                  height: 1.6,
                  softWrap: true,
                ),
                16.sbh,
                SizedBox(
                  width: 240,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onDone,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: MyText(
                      text: "Done",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.28,
                      color: R.theme.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showVerificationSuccessDialog(BuildContext context, {required VoidCallback onDone}) {
  showGeneralDialog(
    context: context,
    // 3. Ensure this is false so clicking outside doesn't close it
    barrierDismissible: false,
    barrierLabel: "Verification Success",
    barrierColor: Colors.black.withOpacity(0.8),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      // 4. ClipRect prevents the blur from bleeding to edges (performance/visual artifact safety)
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: VerificationSuccessPopup(
            onDone: () {
              Navigator.of(context).pop();
              onDone();
            },
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            // Changed to elasticOut for a slightly more playful "success" pop
            // Or keep easeOutBack if you prefer it subtler.
            curve: Curves.easeOutBack,
          ),
          child: child,
        ),
      );
    },
  );
}