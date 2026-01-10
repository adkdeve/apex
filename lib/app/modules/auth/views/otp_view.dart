import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/my_text.dart';
import '../../../../common/widgets/otp_success_popup.dart';
import '../../../../utils/helpers/string_utils.dart';
import '../../../core/core.dart';
import '../../../routes/app_pages.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  final String? email;

  const OtpView({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String displayEmail = email ?? Get.arguments ?? 'user@example.com';
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: R.theme.darkBackground,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 24, bottom: 16),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 24,
                      ),
                      8.sbw,
                      MyText(
                        text: "Back",
                        color: Colors.white,
                        fontSize: 16,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      MyText(
                        text: "OTP Verification",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: R.theme.white,
                      ),

                      8.sbh,

                      MyText(
                        text: "We have sent a verification code to your email address ${maskEmail(displayEmail)}",
                        textAlign: TextAlign.center,
                        color: Colors.grey[400],
                        fontSize: 14,
                        softWrap: true,
                      ),

                      32.sbh,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Obx(() {
                              // Reactive state from Controller
                              bool isSuccess = controller.isSuccess.value;
                              bool isError = controller.isError.value;

                              // Listen to Focus Changes to trigger rebuilds
                              return AnimatedBuilder(
                                animation: controller.focusNodes[index],
                                builder: (context, child) {

                                  bool hasValue = controller.controllers[index].text.isNotEmpty;
                                  bool isFocused = controller.focusNodes[index].hasFocus;

                                  Color borderColor = Colors.grey[700]!;
                                  Color bgColor = Colors.transparent;
                                  Color textColor = R.theme.white;

                                  if (isSuccess) {
                                    borderColor = Colors.green;
                                    bgColor = Colors.green.withOpacity(0.1);
                                    textColor = Colors.green;
                                  } else if (isError) {
                                    borderColor = R.theme.errorColor;
                                    bgColor = R.theme.errorBg;
                                    textColor = R.theme.errorColor;
                                    // CHANGED: Added 'isFocused' to this check
                                  } else if (isFocused || hasValue) {
                                    borderColor = R.theme.secondary;
                                    bgColor = R.theme.goldBg;
                                    textColor = R.theme.secondary;
                                  }

                                  return Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      border: Border.all(
                                        color: borderColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: TextField(
                                        controller: controller.controllers[index],
                                        focusNode: controller.focusNodes[index],
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        onChanged: (val) {
                                          if (val.isEmpty && index > 0) {
                                            controller.focusNodes[index - 1].requestFocus();
                                          }
                                          controller.onChanged(val, index);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          );
                        }),
                      ),

                      Obx(() {
                        if (controller.isError.value) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Color(0xFFff6b6b),
                                  size: 16,
                                ),
                                8.sbw,
                                Text(
                                  "Invalid Code",
                                  style: TextStyle(
                                    color: Color(0xFFff6b6b),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return 24.sbh;
                      }),

                      8.sbh,

                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive code? ",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                            if (controller.canResend.value)
                              GestureDetector(
                                onTap: controller.handleResend,
                                child: Text(
                                  "Resend code",
                                  style: TextStyle(
                                    color: R.theme.secondary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            else
                              Text(
                                controller.formattedTime,
                                style: TextStyle(
                                  color: R.theme.secondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),

                      32.sbh,

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Obx(() {
                          bool isDisabled =
                              controller.currentOtp.value.length != 4;
                          return ElevatedButton(
                            onPressed: isDisabled
                                ? null
                                : () => controller.handleConfirm(
                                    () => showVerificationSuccessDialog(
                                      context,
                                      onDone: () {
                                        Get.offAllNamed(Routes.MAIN);
                                      },
                                    ),
                                  ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: R.theme.secondary,
                              disabledBackgroundColor: R.theme.secondary
                                  .withOpacity(0.5),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: MyText(
                              text: "Confirm",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: R.theme.white,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
