import 'package:get/get.dart';
import 'package:apex/app/data/models/wallet_model.dart';

class WalletController extends GetxController {
  // --- State Variables ---
  var totalBalance = 1544.00.obs;
  var monthlyIncome = 12491.22.obs;
  var rideCount = 244.obs;
  var isLoading = true.obs;

  // Observable Lists for Chart and History
  var chartData = <ChartData>[].obs;
  var transactions = <Transaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWalletData();
  }

  // --- Logic ---
  void fetchWalletData() async {
    isLoading.value = true;

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Populate Chart Data
    chartData.value = [
      ChartData(day: "Mo", value: 1500, isActive: false),
      ChartData(day: "Tu", value: 2200, isActive: false),
      ChartData(day: "We", value: 800, isActive: false),
      ChartData(day: "Th", value: 1500, isActive: false),
      ChartData(day: "Fr", value: 2200, isActive: false),
      ChartData(day: "Sa", value: 800, isActive: false),
      ChartData(day: "Su", value: 1300, isActive: false),
    ];

    // Populate History
    transactions.value = [
      Transaction(amount: "100", date: "14/06/2021, 14:24 AM"),
      Transaction(amount: "224", date: "24/05/2021, 22:30 AM"),
      Transaction(amount: "200", date: "11/04/2021, 16:20 AM"),
      Transaction(amount: "200", date: "11/04/2021, 16:20 AM"),
    ];

    isLoading.value = false;
  }
}
