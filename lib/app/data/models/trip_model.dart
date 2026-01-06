class TripModel {
  final String id;
  final String pickupLocation;
  final String dropoffLocation;
  final String pickupTime;
  final String dropoffTime;
  final String driverName;
  final double rating;
  final String price;
  final String driverImage;

  TripModel({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.pickupTime,
    required this.dropoffTime,
    required this.driverName,
    required this.rating,
    required this.price,
    required this.driverImage,
  });
}

// ----------