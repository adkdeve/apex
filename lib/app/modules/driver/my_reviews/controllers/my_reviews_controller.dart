import 'package:get/get.dart';
import '../../../../data/models/review_model.dart';

class MyReviewsController extends GetxController {
  var reviews = <ReviewModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadReviews();
  }

  void loadReviews() {
    var dummyData = List.generate(4, (index) => ReviewModel(
      id: index.toString(),
      userName: 'Pauline Wheeler',
      userImage: '',
      timeAgo: '1 Day ago',
      rating: 4,
      comment: 'Lorem Ipsum ha sido el texto de relleno estándar de las industrias.',
    ));

    reviews.assignAll(dummyData);
  }
}


