import 'package:flutter/material.dart';
import '../../app/core/core.dart';
import '../../app/data/models/ride_history_model.dart';

class RentalRideCard extends StatelessWidget {
  final RideHistoryModel item;

  const RentalRideCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color labelColor = Color(0xFF757575); // Grey for labels

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: R.theme.cardBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(item.imageUrl),
              ),

              12.sbw,

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.driverName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFC107),
                        size: 14,
                      ),

                      2.sbw,

                      Text(
                        item.rating.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Luxury SUV",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  2.sbh,

                  SizedBox(
                    height: 30,
                    width: 60,
                    child: Image.network(
                      "https://www.pngmart.com/files/4/Car-PNG-HD.png",
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) =>
                          const Icon(Icons.directions_car, color: Colors.grey),
                    ),
                  ),

                  2.sbh,

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "APT 238",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          6.sbh,

          Divider(color: Colors.grey.withOpacity(0.2), thickness: 1),

          6.sbh,

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: Color(0xFFF44336),
                size: 24,
              ), // Red Pin

              12.sbw,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pickup location",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    4.sbh,

                    Text(
                      item.pickupLocation,
                      style: const TextStyle(color: labelColor, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          6.sbh,

          Divider(color: Colors.grey.withOpacity(0.2), thickness: 1),

          6.sbh,

          _buildStatRow(
            "Pickup Time",
            item.pickupTime,
            labelColor,
            R.theme.secondary,
          ), // e.g. "32:32:00 PM"

          6.sbh,

          _buildStatRow("Hourly Rate", "\$100", labelColor, R.theme.secondary),

          6.sbh,

          _buildStatRow(
            "Booked hours",
            item.bookedHours ?? "3 hours",
            labelColor,
            R.theme.secondary,
          ),

          10.sbh,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Estimated total",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "\$${item.price}",
                style: TextStyle(
                  color: R.theme.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(
    String label,
    String value,
    Color labelColor,
    Color valueColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
