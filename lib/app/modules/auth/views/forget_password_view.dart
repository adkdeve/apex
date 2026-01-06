import 'package:apex/common/widgets/build_image.dart';
import 'package:apex/common/widgets/my_text_form_field.dart';
import 'package:apex/common/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/my_text.dart';
import '../../../core/core.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

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
                      const Icon(Icons.chevron_left, color: Colors.white, size: 24),
                      8.sbw,
                      MyText(text: "Back", color: Colors.white, fontSize: 16, textAlign: TextAlign.start),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      buildImage('assets/images/brand.png', context: context),
                      24.sbh,
                      MyText(
                        text:
                            "Forgot Password!",
                        textAlign: TextAlign.center,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      8.sbh,
                      MyText(
                        text:
                            "Not a problem! Please enter your email address to change your password.", // Make dynamic via localization
                        textAlign: TextAlign.center,
                        fontSize: 14,
                        color: Colors.grey[400],
                        height: 1.5,
                        softWrap: true,
                      ),
                      40.sbh,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text:
                              "Email Address",
                          textAlign: TextAlign.start,
                          color: R.theme.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      10.sbh,
                      MyTextFormField(
                        controller: controller.emailController,
                        hinttxt: "your email address",
                        onChange: (_) => controller.emailError.value =
                            false,
                      ),
                      102.sbh,
                      PrimaryButton(
                        text:
                            "Send verification Link",
                        onPressed: controller.handleSendLink,
                        color: R.theme.goldAccent,
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
