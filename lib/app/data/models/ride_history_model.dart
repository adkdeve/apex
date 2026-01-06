enum RideType { standard, rental }

class RideHistoryModel {
  final RideType type;
  final String pickupTime;
  final String? dropTime;
  final String pickupLocation;
  final String? dropLocation;
  final String driverName;
  final double rating;
  final String price;
  final String imageUrl;
  // Rental specific
  final String? bookedHours;
  final String? carName;

  RideHistoryModel({
    required this.type,
    required this.pickupTime,
    this.dropTime,
    required this.pickupLocation,
    this.dropLocation,
    required this.driverName,
    required this.rating,
    required this.price,
    required this.imageUrl,
    this.bookedHours,
    this.carName,
  });
}
