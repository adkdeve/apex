import 'package:apex/app/core/core.dart';
import 'package:apex/utils/helpers/validation_utils.dart';
import 'package:apex/common/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/navigation/custom_app_bar.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactController> {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ContactController());
    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      appBar: CustomAppBar(
        title: "Contact Us",
        backgroundColor: R.theme.darkBackground,
        backButtonColor: Colors.white24,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText(
                text: 'Contact us for Ride share',
                fontSize: 18,
                color: R.theme.textGrey.withOpacity(0.5),
              ),
              24.sbh,

              MyText(text: 'Address', fontSize: 16, color: R.theme.textGrey),
              8.sbh,

              MyText(
                text:
                    'House# 72, Road# 21, Banani, Dhaka-1213 (near Banani Bidyaniketon School &\nCollege, beside University of South Asia)',
                fontSize: 12,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
              16.sbh,

              // Phone and Email Section
              MyText(
                text: 'Call : 13301 (24/7)',
                fontSize: 12,
                color: R.theme.textGrey,
              ),
              4.sbh,

              MyText(
                text: 'Email : support@pathao.com',
                fontSize: 12,
                color: R.theme.textGrey,
              ),
              32.sbh,

              // Send Message Form Header
              MyText(
                text: 'Send Message',
                fontSize: 16,
                color: R.theme.textGrey,
              ),
              14.sbh,

              // Name Field
              _buildTextField(
                controller: controller.nameController,
                hintText: 'Name',
                validator: Validators.validateName,
              ),
              16.sbh,

              // Email Field
              _buildTextField(
                controller: controller.emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              16.sbh,

              // Phone Number Field
              _buildPhoneField(),
              16.sbh,

              // Message Field
              _buildTextField(
                controller: controller.messageController,
                hintText: 'Write your text',
                maxLines: 4,
                validator: Validators.validateMessage,
              ),
              24.sbh,

              // Send Message Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : controller.sendMessage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.goldAccent,
                      foregroundColor: R.theme.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: controller.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.black,
                              ),
                            ),
                          )
                        : MyText(
                            text: 'Send Message',
                            fontSize: 16,
                            color: R.theme.white,
                          ),
                  ),
                ),
              ),

              10.sbh,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        filled: true,
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
        fillColor: Colors.white.withOpacity(0.05),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD4AF37)),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          // Country Code Picker (Static for this example, but can be made interactive)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Placeholder for flag
                Container(
                  width: 24,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(
                  () => Text(
                    controller.countryCode.value,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white.withOpacity(0.5),
                  size: 20,
                ),
              ],
            ),
          ),
          // Vertical divider
          Container(height: 56, width: 1, color: Colors.white.withOpacity(0.3)),
          // Phone Number Input
          Expanded(
            child: TextFormField(
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
              validator: Validators.validatePhone,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Your mobile number',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor:
                    Colors.transparent, // Transparent to use parent's color
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                errorStyle: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
