class ReviewModel {
  final String id;
  final String userName;
  final String userImage;
  final String timeAgo;
  final int rating;
  final String comment;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.timeAgo,
    required this.rating,
    required this.comment,
  });
}