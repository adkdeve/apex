import 'package:apex/common/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/build_image.dart';
import '../../../../common/widgets/field_error.dart';
import '../../../../common/widgets/my_text.dart';
import '../../../core/core.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark
      ),
      child: Scaffold(
        backgroundColor: R.theme.darkBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: buildImage('assets/images/brand.png',context: context)),

                24.sbh,

                MyText(
                  text: "Welcome Back!",
                  textAlign: TextAlign.center,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),

                MyText(
                    text: 'Please enter your credentials to login.',
                    fontSize: 14,
                    color: Color(0xff767676)
                ),

                24.sbh,

                Row(
                  children: [
                    SocialButton(icon: 'assets/icons/ic_google.svg', text: 'Google', onTap: () {}),
                    12.sbw,
                    SocialButton(icon: 'assets/icons/ic_apple.svg', text: 'Apple', onTap: (){}),
                    12.sbw,
                    SocialButton(icon: 'assets/icons/ic_facebook.svg', text: 'Facebook', onTap: (){}),
                  ],
                ),

                12.sbh,

                Row(
                  children: [
                    Expanded(child: Container(height: 1, color: R.theme.white)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: MyText(text: "or", color: Colors.grey, fontSize: 14),
                    ),
                    Expanded(child: Container(height: 1, color: R.theme.white)),
                  ],
                ),

                34.sbh,

                MyText(
                    text: "Email Address",
                    color: R.theme.white,
                    fontSize: 16,
                    textAlign: TextAlign.start
                ),
                8.sbh,
                Obx(() => TextField(
                  controller: controller.emailController,
                  style: TextStyle(color: R.theme.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: "your email address",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: controller.emailError.value ? Colors.red : R.theme.white
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: R.theme.secondary),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
                  ),
                  onChanged: (_) => controller.emailError.value = false,
                )),

                Obx(() => controller.emailError.value
                    ? FieldError(message: "Please enter a valid email address")
                    : const SizedBox.shrink()),

                16.sbh,

                MyText(
                    text: "Password",
                    color: Colors.white,
                    fontSize: 14,
                    textAlign: TextAlign.start
                ),
                8.sbh,
                Obx(() => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,
                  style: TextStyle(color: R.theme.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: "your password",
                    hintStyle: TextStyle(color: Colors.grey[600]),

                    suffixIcon: TextButton(
                      onPressed: () {
                        controller.isPasswordHidden.toggle();
                      },
                      child: Text(
                        // Check the boolean to switch the text
                        controller.isPasswordHidden.value ? "Unhide" : "Hide",
                        style: TextStyle(
                          color: Colors.grey[400], // Matches your previous icon color
                          fontSize: 14, // Adjusted for typical suffix text size
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
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
                  ),
                  onChanged: (_) => controller.passwordError.value = false,
                )),

                Obx(() => controller.passwordError.value
                    ? FieldError(message: "Password cannot be empty")
                    : const SizedBox.shrink()),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: controller.onForgotPassword,
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(color: R.theme.secondary, fontSize: 14),
                    ),
                  ),
                ),

                Obx(() => Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (val) => controller.rememberMe.value = val ?? false,
                        activeColor: R.theme.secondary,
                        checkColor: R.theme.white,
                        side: BorderSide(color: Colors.grey[800]!),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text("Remember me", style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                )),

                24.sbh,

                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.secondary,
                      foregroundColor: R.theme.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),

                24.sbh,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ", style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                    GestureDetector(
                      onTap: controller.onRegister,
                      child: Text("Register", style: TextStyle(color: R.theme.secondary, fontSize: 14)),
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