import 'package:flutter/material.dart';

import '../../app/data/models/review_model.dart';

class ReviewItem extends StatelessWidget {
  final ReviewModel review;

  const ReviewItem({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar Circle
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[300],
          // If userImage is empty, show nothing (grey circle), else show image
          backgroundImage: review.userImage.isNotEmpty
              ? NetworkImage(review.userImage)
              : null,
        ),

        const SizedBox(width: 16),

        // Content Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name and Time Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    review.userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    review.timeAgo,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              // Star Rating
              Row(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Icon(
                      Icons.star,
                      size: 16,
                      // Logic: If index < rating, show amber, else grey
                      color: index < review.rating
                          ? const Color(0xFFFFC107) // Amber
                          : Colors.grey[800],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 8),

              // Comment Text
              Text(
                review.comment,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  height: 1.4, // Line height for readability
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}