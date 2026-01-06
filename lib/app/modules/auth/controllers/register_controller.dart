import 'package:apex/utils/helpers/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  // Text Controllers
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();

  // Error Handling
  var fullNameError = false.obs;
  var phoneError = false.obs;
  var emailError = false.obs;
  var dobError = false.obs;
  var passwordError = false.obs;
  var countryError = false.obs;

  // Reactive State
  var isPasswordHidden = true.obs;
  var selectedCountry = ''.obs;
  var selectedDate = Rxn<DateTime>();
  var agreedToTerms = false.obs;

  // Country Options (Matching your React list)
  final List<Map<String, String>> countries = [
    {'code': 'US', 'name': 'United States'},
    {'code': 'UK', 'name': 'United Kingdom'},
    {'code': 'CA', 'name': 'Canada'},
    {'code': 'AU', 'name': 'Australia'},
    {'code': 'IN', 'name': 'India'},
    {'code': 'NG', 'name': 'Nigeria'},
    {'code': 'ZA', 'name': 'South Africa'},
    {'code': 'KE', 'name': 'Kenya'},
    {'code': 'GH', 'name': 'Ghana'},
    {'code': 'OTHER', 'name': 'Other'},
  ];

  // Date Picker Logic
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: const Color(0xFFC8A74E),
            scaffoldBackgroundColor: Colors.black,
            dialogBackgroundColor: Colors.black,
            useMaterial3: true,
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFC8A74E),
              surface: Color(0xFF1E1E1E),
              onSurface: Colors.white,
              inversePrimary: Color(0xFFC8A74E),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;

      // 2. CRITICAL: Update the text controller here
      dobController.text = DateFormat('yyyy-MM-dd').format(picked);

      // Reset error if needed
      dobError.value = false;
    }
  }

  // Sign Up Logic
  void handleSignUp() {
    // Reset all errors
    fullNameError.value = false;
    phoneError.value = false;
    emailError.value = false;
    dobError.value = false;
    passwordError.value = false;
    countryError.value = false;

    bool hasError = false;
    String errorField = '';

    if (fullNameController.text.isEmpty) {
      print('❌ Full Name is empty');
      fullNameError.value = true;
      hasError = true;
      errorField = 'Full Name';
    }

    if (phoneController.text.isEmpty) {
      print('❌ Phone is empty');
      phoneError.value = true;
      hasError = true;
      errorField = 'Phone';
    }

    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      print('❌ Email is invalid: ${emailController.text}');
      emailError.value = true;
      hasError = true;
      errorField = 'Email';
    }

    if (selectedDate.value == null) {
      print('❌ Date of Birth not selected');
      dobError.value = true;
      hasError = true;
      errorField = 'Date of Birth';
    }

    if (passwordController.text.isEmpty) {
      print('❌ Password is empty');
      passwordError.value = true;
      hasError = true;
      errorField = 'Password';
    }

    // Country is optional - removed this check
    // if (selectedCountry.value.isEmpty) {
    //   countryError.value = true;
    //   hasError = true;
    // }

    if (!agreedToTerms.value) {
      print('❌ Terms not agreed');
      SnackBarUtils.errorMsg("Please agree to terms & conditions");
      return;
    }

    if (hasError) {
      print('❌ Validation failed for: $errorField');
      SnackBarUtils.errorMsg("Please fill: $errorField");
      return;
    }

    // Debug: Print validation passed
    print('✅ Validation passed, navigating to OTP...');
    print('Name: ${fullNameController.text}');
    print('Phone: ${phoneController.text}');
    print('Email: ${emailController.text}');
    print('DOB: ${dobController.text}');
    print('Country: ${selectedCountry.value}');

    Get.toNamed(Routes.OTP, arguments: emailController.text)
        ?.then((_) {
          print('✅ Successfully navigated to OTP');
        })
        .catchError((e) {
          print('❌ Navigation failed: $e');
          SnackBarUtils.errorMsg(
            "Navigation failed. Please check route configuration.",
          );
        });
  }

  void onLogin() {
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dobController.dispose();
    super.onClose();
  }
}
