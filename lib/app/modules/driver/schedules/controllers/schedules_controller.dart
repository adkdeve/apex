import 'package:get/get.dart';
import '../../../../../common/widgets/schedule_card.dart';
import '../../../../../utils/helpers/snackbar.dart';
// Import your ScheduleModel here.
// If you put it in the view file temporarily, import that file.
// Or ideally move ScheduleModel to: data/models/schedule_model.dart

class SchedulesController extends GetxController {

  // 1. Change single variables to an Observable List
  final RxList<ScheduleModel> schedules = <ScheduleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSchedules();
  }

  void loadSchedules() {
    // 2. Populate with dummy data for now
    schedules.assignAll([
      ScheduleModel(
        passengerName: "Esther Berry",
        passengerImage: "https://i.pravatar.cc/150?img=5",
        pickupLabel: "Current location",
        pickupAddress: "2972 Westheimer Rd. Santa Ana, Illinois 85486",
        dropoffLabel: "Airport",
        dropoffAddress: "1901 Thornridge Cir. Shiloh, Hawaii 81063",
        distance: "1.1km",
        travelTime: "~44min.",
        baseFare: "\$9,00",
        distanceFare: "\$9,00",
        timeFare: "\$9,00",
        totalEstimate: "\$20,00",
        scheduledTime: "8:00-9:00 AM, 09 Dec",
      ),
      ScheduleModel(
        passengerName: "John Doe",
        passengerImage: "https://i.pravatar.cc/150?img=12",
        pickupLabel: "Office",
        pickupAddress: "4517 Washington Ave. Manchester, Kentucky 39495",
        dropoffLabel: "Home",
        dropoffAddress: "3891 Ranchview Dr. Richardson, California 62639",
        distance: "5.4km",
        travelTime: "~20min.",
        baseFare: "\$12,00",
        distanceFare: "\$5,00",
        timeFare: "\$3,00",
        totalEstimate: "\$25,00",
        scheduledTime: "10:00-11:00 AM, 10 Dec",
      ),
    ]);
  }

  // 3. Update startRide to accept the specific ride model
  void startRide(ScheduleModel ride) {
    SnackBarUtils.successMsg("You have started the trip for ${ride.passengerName}");
    // Add logic here to navigate to navigation screen or update backend
  }

  void goBack() {
    Get.back();
  }
}