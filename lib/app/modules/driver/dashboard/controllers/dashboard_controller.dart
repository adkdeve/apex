import 'package:get/get.dart';
import '../../../../data/models/activity_log.dart';

class DashboardController extends GetxController {
  final String userName = "John";

  var isShiftActive = true.obs;
  var workedHours = "4h 20m".obs;
  var remainingHours = "3h 40m".obs;
  var overtime = "0h".obs;

  var dailyProgress = 0.55.obs;

  final List<ActivityLog> logs = [
    ActivityLog(icon: 'clock_in', title: "Clock In", time: "9:00 AM", color: 0xFF4CAF50),
    ActivityLog(icon: 'pause', title: "Break Started", time: "12:10 PM", color: 0xFFFFA726),
    ActivityLog(icon: 'play', title: "Break Ended", time: "12:40 PM", color: 0xFF42A5F5),
    ActivityLog(icon: 'clock_out', title: "Clock Out", time: "5:00 PM", color: 0xFFEF5350),
  ];

  var currentNavIndex = 0.obs;

  void changeTabIndex(int index) {
    currentNavIndex.value = index;
  }
}

