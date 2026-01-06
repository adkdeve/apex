import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/build_image.dart';
import '../../../../core/core.dart';
import '../../../../data/models/place_model.dart' as app;
import '../controllers/search_controller.dart' as app;

class SearchView extends GetView<app.SearchController> {
  SearchView({Key? key}) : super(key: key);

  final Color _textGrey = const Color(0xFF888888);
  final Color _subTextGrey = R.theme.subTextGrey;

  @override
  Widget build(BuildContext context) {
    Get.put(app.SearchController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  _buildHeader(),

                  Expanded(
                    child: Obx(() {
                      if (controller.searchQuery.value.isNotEmpty &&
                          controller.filteredPlaces.isEmpty) {
                        return _buildNotFoundView(context);
                      }

                      return Column(
                        children: [
                          if (controller.searchQuery.value.isEmpty)
                            _buildRecentPlacesHeader(),
                          Expanded(child: _buildPlacesList()),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.onBack,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: R.theme.cardBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          12.sbw,

          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: R.theme.secondary, width: 1),
              ),
              child: Row(
                children: [
                  16.sbw,

                  Icon(
                    Icons.location_on_outlined,
                    color: _subTextGrey,
                    size: 16,
                  ),

                  12.sbw,

                  Expanded(
                    child: TextField(
                      onChanged: controller.updateSearch,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      cursorColor: R.theme.secondary,
                      decoration: InputDecoration(
                        hintText: "Search address",
                        hintStyle: TextStyle(color: _subTextGrey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(bottom: 10),
                      ),
                    ),
                  ),

                  Obx(() {
                    if (controller.searchQuery.value.isNotEmpty) {
                      return GestureDetector(
                        onTap: controller.clearSearch,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.close,
                            color: Color(0xFF888888),
                            size: 18,
                          ),
                        ),
                      );
                    }
                    return const SizedBox(width: 16);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotFoundView(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                    ),
                    children: [
                      TextSpan(
                        text: "Results for ",
                        style: TextStyle(color: _subTextGrey),
                      ),
                      TextSpan(
                        text: '"${controller.searchQuery.value}"',
                        style: TextStyle(color: R.theme.secondary),
                      ),
                    ],
                  ),
                ),
                Text(
                  "0 found",
                  style: TextStyle(
                    color: R.theme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: buildImage('assets/icons/no_data.svg', context: context),
          ),

          const SizedBox(height: 30),

          const Text(
            "Not Found",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist',
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "Sorry, the keyword you entered cannot be found, please check again or search with another keyword",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _textGrey,
              fontSize: 14,
              height: 1.5,
              fontFamily: 'Urbanist',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentPlacesHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Recent places",
            style: TextStyle(
              color: _subTextGrey,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: 'Montserrat',
            ),
          ),
          GestureDetector(
            onTap: controller.clearAllHistory,
            child: Text(
              "Clear All",
              style: TextStyle(
                color: R.theme.secondary,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlacesList() {
    return Obx(() {
      return ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
        itemCount: controller.filteredPlaces.length,
        itemBuilder: (context, index) {
          final place = controller.filteredPlaces[index];
          return _buildPlaceItem(place);
        },
      );
    });
  }

  Widget _buildPlaceItem(app.Place place) {
    return InkWell(
      onTap: () => controller.onSelectPlace(place),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 2),
              child: Icon(Icons.access_time, color: _subTextGrey, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        place.name,
                        style: const TextStyle(
                          color: Color(0xFFD0D0D0),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                      Text(
                        place.distance,
                        style: TextStyle(
                          color: _textGrey,
                          fontSize: 14,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    place.address,
                    style: TextStyle(
                      color: _subTextGrey,
                      fontSize: 13,
                      fontFamily: 'Urbanist',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
