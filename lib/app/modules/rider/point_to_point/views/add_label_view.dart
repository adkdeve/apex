import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:apex/common/widgets/navigation/back_button_header.dart';
import '../../../../../common/widgets/navigation/custom_app_bar.dart';
import '../../../../core/core.dart';
import '../controllers/add_label_controller.dart';

class AddLabelView extends GetView<AddLabelController> {
  const AddLabelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: R.theme.darkBackground,
        appBar: CustomAppBar(title: 'Add Label'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [

                _buildLabelOption(
                  icon: Icons.home_outlined,
                  title: "Home",
                  subtitle: "Set home",
                  primaryGold: R.theme.secondary,
                  textWhite: R.theme.white,
                  textGrey: R.theme.grey,
                  onTap: () {},
                ),

                24.sbh,

                _buildLabelOption(
                  icon: Icons.work_outline,
                  title: "Work",
                  subtitle: "Set work",
                  primaryGold: R.theme.secondary,
                  textWhite: R.theme.white,
                  textGrey: R.theme.grey,
                  onTap: () {},
                ),

                24.sbh,

                Expanded(
                  child: Obx(
                    () => ListView.separated(
                      itemCount: controller.savedPlaces.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 24),
                      itemBuilder: (context, index) {
                        final place = controller.savedPlaces[index];
                        return _buildLabelOption(
                          icon: Icons.place_outlined,
                          title: place.name,
                          subtitle: place.address,
                          primaryGold: R.theme.secondary,
                          textWhite: R.theme.white,
                          textGrey: R.theme.grey,
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.goToSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Add a Place",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
                      ),
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

  Widget _buildLabelOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color primaryGold,
    required Color textWhite,
    required Color textGrey,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: primaryGold,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),

          16.sbw,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Urbanist',
                  ),
                ),
                4.sbh,
                Text(
                  subtitle,
                  style: TextStyle(
                    color: textGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Urbanist',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
