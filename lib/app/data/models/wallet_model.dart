class ChartData {
  final String day;
  final double value;
  final bool isActive;

  ChartData({required this.day, required this.value, required this.isActive});
}

class Transaction {
  final String amount;
  final String date;

  Transaction({required this.amount, required this.date});
}
