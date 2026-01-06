import 'package:get/get.dart';
import '../../../../data/models/trip_model.dart';

class CompletedTripsController extends GetxController {
  var completedTrips = <TripModel>[].obs;

  var selectedFilter = 'This Month'.obs;

  @override
  void onInit() {
    super.onInit();
    loadTrips();
  }

  void loadTrips() {
    var dummyData = [
      TripModel(
        id: '1',
        pickupLocation: 'State Park',
        dropoffLocation: 'Home',
        pickupTime: '7:34 AM',
        dropoffTime: '7:48 AM',
        driverName: 'Michael Bracewell',
        rating: 4.9,
        price: '9,00',
        driverImage: 'https://i.pravatar.cc/150?img=11', // Placeholder
      ),
      TripModel(
        id: '2',
        pickupLocation: 'State Park',
        dropoffLocation: 'Home',
        pickupTime: '7:34 AM',
        dropoffTime: '7:48 AM',
        driverName: 'Michael Bracewell',
        rating: 4.9,
        price: '9,00',
        driverImage: 'https://i.pravatar.cc/150?img=11',
      ),
    ];
    completedTrips.assignAll(dummyData);
  }
}


