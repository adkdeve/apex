import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../core/core.dart';
import '../../../../data/models/wallet_model.dart';
import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Wallet",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: R.theme.secondary,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                color: R.theme.secondary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: R.theme.secondary,
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          _buildSummaryCard(),
                          16.sbh,
                          _buildChartCard(),
                          16.sbh,
                          _buildHistoryCard(),
                          100.sbh,
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      height: 145,
      padding: 20.all,
      decoration: BoxDecoration(color: R.theme.cardBg, borderRadius: 20.radius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText(
                text: "Last 1 Month",
                textAlign: TextAlign.center,
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),

              8.sbh,

              Obx(
                () => MyText(
                  text:
                      "\$ ${controller.monthlyIncome.value.toStringAsFixed(2)}",
                  textAlign: TextAlign.center,
                  color: R.theme.secondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Column(
            children: [
              Divider(color: Colors.white.withOpacity(0.15), height: 1),

              12.sbh,

              Row(
                children: [
                  const Icon(Icons.repeat, color: Colors.white, size: 18),

                  8.sbw,

                  Obx(
                    () => Text(
                      "${controller.rideCount.value} Rides",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard() {
    return Container(
      height: 340, // Slightly increased height to accommodate layout
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: R.theme.cardBgVariant, // Or R.theme.cardBg
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Wallet Balance",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          // Reactive Balance
          Obx(
            () => Text(
              "\$ ${controller.totalBalance.value.toStringAsFixed(2)}",
              style: TextStyle(
                color: R.theme.secondary, // Your gold color
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Chart Area
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    // Layer 1: Y-Axis Labels & Grid Lines
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildGridLine("2000"),
                        _buildGridLine("1000"),
                        _buildGridLine("500"),
                        // Empty spacer for the bottom (0 level) to align with X-axis
                        const SizedBox(height: 20),
                      ],
                    ),

                    // Layer 2: The Bars
                    // We add padding to the left to avoid overlapping the Y-axis text
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        bottom: 20,
                      ), // bottom 20 makes room for X-axis labels
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Add a spacer at the start to center bars slightly if needed
                          ...controller.chartData
                              .map(
                                (data) =>
                                    _buildBar(data, constraints.maxHeight - 20),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridLine(String label) {
    return Row(
      children: [
        SizedBox(
          width: 35, // Fixed width for Y-axis labels
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.white.withOpacity(0.1), // Faint grid line
          ),
        ),
      ],
    );
  }

  Widget _buildBar(ChartData data, double availableSpace) {
    // 1. Define the static height needed for Text + Spacing
    const double textAndSpacingHeight =
        30.0; // 12 (SizedBox) + ~18 (Text height)

    // 2. Calculate the actual max height available for the COLORED BAR only
    final double maxBarHeight = availableSpace - textAndSpacingHeight;

    // 3. Prevent negative height if screen is extremely small
    if (maxBarHeight < 0) return const SizedBox();

    const double maxValue = 2500;

    // 4. Calculate height relative to the corrected maxBarHeight
    final double calculatedHeight = (data.value / maxValue) * maxBarHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          width: 8,
          height: calculatedHeight, // Uses the corrected height
          decoration: BoxDecoration(
            color: R.theme.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          data.day,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryCard() {
    return Container(
      padding: 20.all,
      decoration: BoxDecoration(color: R.theme.cardBg, borderRadius: 20.radius),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: "Withdrawal History",
                textAlign: TextAlign.start,
                color: R.theme.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MyText(
                  text: "View All",
                  color: R.theme.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          20.sbh,

          Obx(
            () => Column(
              children: controller.transactions.asMap().entries.map((entry) {
                int idx = entry.key;
                var tx = entry.value;
                bool isLast = idx == controller.transactions.length - 1;
                return _buildTransactionItem(tx, isLast: isLast);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Transaction tx, {bool isLast = false}) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: R.theme.secondary,
                borderRadius: 6.radius,
              ),
            ),

            12.sbw,

            MyText(text: tx.date, color: Colors.white, fontSize: 14),

            const Spacer(),

            MyText(
              text: "\$${tx.amount}",
              color: Color(0xFF219653),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        if (!isLast) ...[
          12.sbh,

          Divider(color: Colors.white.withOpacity(0.05), height: 1),

          12.sbh,
        ],
      ],
    );
  }
}
