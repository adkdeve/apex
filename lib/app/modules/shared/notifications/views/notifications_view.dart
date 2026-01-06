import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:apex/common/widgets/navigation/back_button_header.dart';
import '../../../../core/core.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color mainBgColor = Color(0xFF0B0B0C);
    const Color cardBgColor = Color(0xFF1F1F1F); // Slightly lighter for cards
    final Color primaryGold = R.theme.goldAccent;
    final Color buttonBg = R.theme.cardBg;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: mainBgColor,
        body: SafeArea(
          child: Column(
            children: [
              // --- Header ---
              BackButtonHeader(title: "Notifications", buttonBg: buttonBg),

              // --- Notification List ---
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // -- TODAY SECTION --
                    _buildSectionHeader(
                      "Today",
                      showClearAll: true,
                      onClearAll: () {
                        // Handle clear all logic
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildNotificationItem(
                      icon: Icons.payment_rounded,
                      title: "Payment Successfully!",
                      subtitle:
                          "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                      cardBgColor: cardBgColor,
                      iconColor: primaryGold,
                    ),
                    const SizedBox(height: 12),
                    _buildNotificationItem(
                      icon: Icons.percent_rounded,
                      title: "30% Special Discount!",
                      subtitle:
                          "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                      cardBgColor: cardBgColor,
                      iconColor: primaryGold,
                    ),

                    const SizedBox(height: 24),

                    // -- YESTERDAY SECTION --
                    _buildSectionHeader("Yesterday"),
                    const SizedBox(height: 16),
                    _buildNotificationItem(
                      icon: Icons.payment_rounded,
                      title: "Payment Successfully!",
                      subtitle:
                          "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                      cardBgColor: cardBgColor,
                      iconColor: primaryGold,
                    ),
                    const SizedBox(height: 12),
                    _buildNotificationItem(
                      icon: Icons.credit_card_rounded,
                      title: "Credit Card added!",
                      subtitle:
                          "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                      cardBgColor: cardBgColor,
                      iconColor: primaryGold,
                    ),
                    const SizedBox(height: 12),
                    _buildNotificationItem(
                      icon: Icons.account_balance_wallet_rounded,
                      title: "Added Money wallet Successfully!",
                      subtitle:
                          "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                      cardBgColor: cardBgColor,
                      iconColor: primaryGold,
                    ),
                    const SizedBox(height: 12),
                    _buildNotificationItem(
                      icon: Icons.percent_rounded,
                      title: "5% Special Discount!",
                      subtitle:
                          "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                      cardBgColor: cardBgColor,
                      iconColor: primaryGold,
                    ),

                    const SizedBox(height: 24),

                    // -- DATE SECTION --
                    _buildSectionHeader("May, 27 2023"),
                    const SizedBox(height: 16),
                    _buildNotificationItem(
                      icon: Icons.payment_rounded,
                      title: "Payment Successfully!",
                      subtitle:
                          "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                      cardBgColor: cardBgColor,
                      iconColor: primaryGold,
                    ),

                    // Bottom padding
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionHeader(
    String title, {
    bool showClearAll = false,
    VoidCallback? onClearAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Urbanist',
          ),
        ),
        if (showClearAll)
          GestureDetector(
            onTap: onClearAll,
            child: Text(
              "clear all",
              style: TextStyle(
                color: R.theme.goldAccent, // Gold
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Urbanist',
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color cardBgColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Box
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15), // Semi-transparent background
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Urbanist',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: R.theme.textGrey, // Text Grey
                    fontSize: 12,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Urbanist',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
