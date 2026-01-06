import 'package:apex/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:apex/utils/helpers/input_formatters.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  final ProfileController controller = Get.put(ProfileController());

  // --- Theme Colors extracted from Image ---
  final Color _bgBlack = const Color(0xFF000000);
  final Color _goldColor = R.theme.goldAccent; // Gold for buttons/text
  final Color _textWhite = const Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgBlack,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Custom App Bar
            _buildAppBar(),

            // 2. Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // Avatar with Camera Icon
                    _buildAvatarSection(),

                    const SizedBox(height: 32),

                    // Form Fields
                    _buildLabel("First Name"),
                    _buildTextField(
                      "First Name",
                      controller.firstNameController,
                    ),

                    const SizedBox(height: 16),

                    _buildLabel("Last Name"),
                    _buildTextField("Last Name", controller.lastNameController),

                    const SizedBox(height: 16),

                    _buildLabel("Email"),
                    _buildTextField(
                      "Email",
                      controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    _buildLabel("Phone Number"),
                    _buildTextField(
                      "Phone Number",
                      controller.phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                        PhoneNumberFormatter(),
                      ],
                    ),

                    const SizedBox(height: 16),

                    _buildLabel("City"),
                    _buildTextField("city", controller.cityController),

                    const SizedBox(height: 40),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _goldColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    100.sbh,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Components ---

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E), // Lighter grey for button bg
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          // Title
          const Text(
            "Personal Info",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Edit Text Button
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(
              "Edit",
              style: TextStyle(
                color: _goldColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Stack(
      children: [
        // Main Avatar Image
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.transparent, width: 0),
            image: const DecorationImage(
              image: NetworkImage(
                "https://i.pravatar.cc/300",
              ), // Replace with actual user image
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Camera Icon Badge
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E), // Dark grey background for icon
              shape: BoxShape.circle,
              border: Border.all(
                color: _bgBlack,
                width: 2,
              ), // Black border to separate from avatar
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            color: _textWhite,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E), // _fieldBg
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller, // Connect the controller here
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF6C6C6C)), // _textHint
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          isDense: true,
        ),
      ),
    );
  }
}
