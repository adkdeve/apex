class RideBookingData {
  final String pickupAddress;
  final String dropoffAddress;
  final double pickupLat;
  final double pickupLng;
  final double dropoffLat;
  final double dropoffLng;
  final String? rideType;
  final String? selectedVehicle;
  final String? estimatedFare;
  final String? estimatedTime;
  final String? estimatedDistance;

  RideBookingData({
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropoffLat,
    required this.dropoffLng,
    this.rideType,
    this.selectedVehicle,
    this.estimatedFare,
    this.estimatedTime,
    this.estimatedDistance,
  });

  Map<String, dynamic> toJson() => {
    'pickupAddress': pickupAddress,
    'dropoffAddress': dropoffAddress,
    'pickupLat': pickupLat,
    'pickupLng': pickupLng,
    'dropoffLat': dropoffLat,
    'dropoffLng': dropoffLng,
    'rideType': rideType,
    'selectedVehicle': selectedVehicle,
    'estimatedFare': estimatedFare,
    'estimatedTime': estimatedTime,
    'estimatedDistance': estimatedDistance,
  };

  factory RideBookingData.fromJson(Map<String, dynamic> json) =>
      RideBookingData(
        pickupAddress: json['pickupAddress'],
        dropoffAddress: json['dropoffAddress'],
        pickupLat: json['pickupLat'],
        pickupLng: json['pickupLng'],
        dropoffLat: json['dropoffLat'],
        dropoffLng: json['dropoffLng'],
        rideType: json['rideType'],
        selectedVehicle: json['selectedVehicle'],
        estimatedFare: json['estimatedFare'],
        estimatedTime: json['estimatedTime'],
        estimatedDistance: json['estimatedDistance'],
      );
}

class ActiveRideData {
  final RideBookingData bookingData;
  final String driverId;
  final String driverName;
  final String driverRating;
  final String driverPhone;
  final String carModel;
  final String plateNumber;
  final String arrivalTime;
  final String actualFare;

  ActiveRideData({
    required this.bookingData,
    required this.driverId,
    required this.driverName,
    required this.driverRating,
    required this.driverPhone,
    required this.carModel,
    required this.plateNumber,
    required this.arrivalTime,
    required this.actualFare,
  });
}
