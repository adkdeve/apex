import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/navigation/custom_app_bar.dart';
import '../../../../core/core.dart';
import '../controllers/search_location_controller.dart';

class SearchLocationView extends GetView<SearchLocationController> {
  const SearchLocationView({Key? key}) : super(key: key);

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
        appBar: CustomAppBar(title: 'Search Location'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: R.theme.cardBg,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      12.sbw,
                      Expanded(
                        child: TextField(
                          controller: controller.searchInputController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Enter an address",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          // Add search logic here
                        ),
                      ),
                    ],
                  ),
                ),
                24.sbh,
                InkWell(
                  onTap: controller.goToMapPicker,
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: R.theme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.map_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      16.sbw,
                      Text(
                        "Choose on map",
                        style: TextStyle(
                          color: R.theme.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                    ],
                  ),
                ),
                24.sbh,
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.searchResults.length,
                      itemBuilder: (context, index) {
                        final place = controller.searchResults[index];
                        return ListTile(
                          leading: const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          title: Text(
                            place['display_name'] ?? 'Unnamed place',
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () => controller.selectSearchResult(place),
                        );
                      },
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
