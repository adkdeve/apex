import 'package:apex/common/widgets/build_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/field_error.dart';
import '../../../../common/widgets/my_text.dart';
import '../../../../common/widgets/social_button.dart';
import '../../../core/core.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration getDecoration(String hint) {
      return InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        hintText: hint,
        hintStyle: TextStyle(color: R.theme.white, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: controller.passwordError.value ? Colors.red : R.theme.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: R.theme.secondary),
        ),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: buildImage(
                    'assets/images/brand.png',
                    context: context,
                  ),
                ),

                24.sbh,

                MyText(
                  text: "Register Now!",
                  textAlign: TextAlign.center,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: R.theme.white,
                ),

                8.sbh,

                MyText(
                  text: "Please register to explore amazing features.",
                  textAlign: TextAlign.center,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff767676),
                ),

                24.sbh,

                Row(
                  children: [
                    SocialButton(
                      icon: 'assets/icons/ic_google.svg',
                      text: 'Google',
                      onTap: () {},
                    ),
                    12.sbw,
                    SocialButton(
                      icon: 'assets/icons/ic_apple.svg',
                      text: 'Apple',
                      onTap: () {},
                    ),
                    12.sbw,
                    SocialButton(
                      icon: 'assets/icons/ic_facebook.svg',
                      text: 'Facebook',
                      onTap: () {},
                    ),
                  ],
                ),

                12.sbh,

                Row(
                  children: [
                    Expanded(child: Container(height: 1, color: R.theme.white)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: MyText(
                        text: "or",
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(child: Container(height: 1, color: R.theme.white)),
                  ],
                ),

                24.sbh,

                MyText(
                  text: "Full Name",
                  textAlign: TextAlign.start,
                  color: R.theme.white,
                  fontSize: 16,
                ),

                10.sbh,

                Obx(
                  () => TextField(
                    controller: controller.fullNameController,
                    style: TextStyle(color: R.theme.white),
                    decoration: getDecoration("your full name"),
                    onChanged: (_) => controller.fullNameError.value = false,
                  ),
                ),
                Obx(
                  () => controller.fullNameError.value
                      ? FieldError(message: "Full Name cannot be empty")
                      : const SizedBox.shrink(),
                ),

                16.sbh,

                MyText(
                  text: "Phone Number",
                  textAlign: TextAlign.start,
                  color: R.theme.white,
                  fontSize: 16,
                ),

                8.sbh,

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: R.theme.white),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.flag,
                                color: Colors.white,
                                size: 18,
                              ), // replace with country flag
                              const SizedBox(width: 6),
                              const Text(
                                "+1",
                                style: TextStyle(color: Colors.white),
                              ), // country code
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        8.sbw,
                        Expanded(
                          child: Obx(
                            () => TextField(
                              controller: controller.phoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              style: TextStyle(color: R.theme.white),
                              decoration: InputDecoration(
                                hintText: "your phone number",
                                hintStyle: TextStyle(color: R.theme.white),
                                filled: true,
                                fillColor: Colors.transparent,

                                // Default border (optional fallback)
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: R.theme.white),
                                ),

                                // FIX: This is where we use the Rx variable 'phoneError.value'
                                // The Obx will now have something to listen to!
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: controller.phoneError.value
                                        ? Colors.red
                                        : R.theme.white,
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: R.theme.secondary,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                              ),
                              onChanged: (_) =>
                                  controller.phoneError.value = false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                16.sbh,

                MyText(
                  text: "Email Address",
                  textAlign: TextAlign.start,
                  color: R.theme.white,
                  fontSize: 16,
                ),

                8.sbh,

                Obx(
                  () => TextField(
                    controller: controller.emailController,
                    style: TextStyle(color: R.theme.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: "your email address",
                      hintStyle: TextStyle(color: R.theme.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: controller.emailError.value
                              ? Colors.red
                              : R.theme.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: R.theme.secondary),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 14,
                      ),
                    ),
                    onChanged: (_) => controller.emailError.value = false,
                  ),
                ),
                Obx(
                  () => controller.emailError.value
                      ? FieldError(message: "Enter a valid email")
                      : const SizedBox.shrink(),
                ),

                16.sbh,

                MyText(
                  text: "Date of Birth",
                  textAlign: TextAlign.start,
                  color: R.theme.white,
                  fontSize: 16,
                ),

                8.sbh,

                GestureDetector(
                  onTap: () => controller.pickDate(context),
                  child: AbsorbPointer(
                    child: Obx(
                          () => TextField(
                        controller: controller.dobController,
                        style: TextStyle(
                          color: R.theme.white,
                        ),
                        decoration: getDecoration("YYYY-MM-DD").copyWith(
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: R.theme.color400,
                            size: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: controller.dobError.value
                                  ? R.theme.error
                                  : R.theme.borderUnfocused,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: controller.dobError.value
                                  ? R.theme.error
                                  : R.theme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => controller.dobError.value
                      ? FieldError(message: "Please select your date of birth")
                      : const SizedBox.shrink(),
                ),

                16.sbh,

                MyText(
                  text: "Create Password",
                  textAlign: TextAlign.start,
                  color: R.theme.white,
                  fontSize: 16,
                ),

                8.sbh,

                Obx(
                  () => TextField(
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordHidden.value,
                    style: TextStyle(color: R.theme.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: "your password",
                      hintStyle: TextStyle(color: R.theme.white),

                      suffixIcon: TextButton(
                        onPressed: () {
                          controller.isPasswordHidden.toggle();
                        },
                        child: Text(
                          // Check the boolean to switch the text
                          controller.isPasswordHidden.value ? "Unhide" : "Hide",
                          style: TextStyle(
                            color: Colors
                                .grey[400], // Matches your previous icon color
                            fontSize:
                                14, // Adjusted for typical suffix text size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: controller.passwordError.value
                              ? Colors.red
                              : R.theme.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: R.theme.secondary),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 14,
                      ),
                    ),
                    onChanged: (_) => controller.passwordError.value = false,
                  ),
                ),
                Obx(
                  () => controller.passwordError.value
                      ? FieldError(message: "Password cannot be empty")
                      : const SizedBox.shrink(),
                ),

                24.sbh,

                Obx(
                  () => Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: controller.agreedToTerms.value,
                          onChanged: (val) =>
                              controller.agreedToTerms.value = val ?? false,
                          activeColor: R.theme.secondary,
                          checkColor: R.theme.white,
                          side: BorderSide(color: Colors.grey[800]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "I agree to all ",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: "Terms & Conditions",
                                style: TextStyle(
                                  color: R.theme.secondary, // secondary color
                                  decoration:
                                      TextDecoration.underline, // underline
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to Terms & Conditions screen
                                    Get.toNamed('/terms-conditions');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                24.sbh,

                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.secondary,
                      foregroundColor: R.theme.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                24.sbh,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: controller.onLogin,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: R.theme.secondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
