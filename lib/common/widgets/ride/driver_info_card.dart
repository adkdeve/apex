import 'package:flutter/material.dart';

class DriverInfoCard extends StatelessWidget {
  const DriverInfoCard({
    Key? key,
    required this.driverName,
    required this.rating,
    this.avatarUrl,
    this.carModel,
    this.carImageUrl,
    this.plateNumber,
    this.backgroundColor,
    this.showCarInfo = true,
    this.avatarSize = 24,
    this.onTap,
  }) : super(key: key);

  final String driverName;
  final double rating;
  final String? avatarUrl;
  final String? carModel;
  final String? carImageUrl;
  final String? plateNumber;
  final Color? backgroundColor;
  final bool showCarInfo;
  final double avatarSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color defaultBg = backgroundColor ?? const Color(0xFF1F1F1F);

    Widget card = Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: defaultBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: avatarSize,
            backgroundColor: Colors.grey[800],
            backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
            child: avatarUrl == null
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          // Name & Rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driverName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFD700), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                if (carModel != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    carModel!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Car Image & Plate (if showCarInfo is true)
          if (showCarInfo)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (carImageUrl != null)
                  SizedBox(
                    height: 35,
                    width: 50,
                    child: Image.network(
                      carImageUrl!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.directions_car_filled,
                              color: Colors.white, size: 50),
                    ),
                  )
                else
                  const Icon(Icons.directions_car_filled,
                      color: Colors.white, size: 50),
                if (plateNumber != null) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      plateNumber!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: card,
      );
    }

    return card;
  }
}

