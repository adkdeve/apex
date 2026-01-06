import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:apex/common/widgets/navigation/custom_app_bar.dart';
import 'package:apex/common/widgets/sheets/success_bottom_sheet.dart';
import 'package:apex/utils/helpers/input_formatters.dart';
import 'package:apex/utils/helpers/snackbar.dart';

import '../../../../core/core.dart';
import '../../../../routes/app_pages.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({Key? key}) : super(key: key);

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  // Track selected payment method (Default to 0: Google Pay)
  int _selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    // --- Colors & Styles ---
    const Color bgDark = Color(0xFF0B0B0C);
    const Color primaryGold = Color(0xFFCFA854);
    const Color textWhite = Colors.white;

    return Scaffold(
      backgroundColor: bgDark,
      // --- APP BAR ---
      appBar: CustomAppBar(
        title: "Payment Method",
        backgroundColor: bgDark,
        backButtonColor: Colors.white24,
      ),

      // --- BODY ---
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // --- Payment Options List ---
            _buildOptionItem(
              0,
              "Google Pay",
              "Balance : \$250.00",
              Icons.account_balance_wallet,
            ),
            const SizedBox(height: 16),
            _buildOptionItem(1, "Cash", "Prepare your cash", Icons.money),
            const SizedBox(height: 16),
            _buildOptionItem(
              2,
              "Credit Card",
              "Visa or Master Card",
              Icons.credit_card,
            ),
            const SizedBox(height: 16),
            _buildOptionItem(
              3,
              "Apple Pay",
              "Pay with your apple balance",
              Icons.phone_iphone,
            ),

            const Spacer(),

            // --- Bottom Buttons ---

            // 1. Add Card (Outlined Button)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () {
                  _showAddCardBottomSheet(context);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: primaryGold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Add Card",
                  style: TextStyle(
                    color: primaryGold,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 2. Pay Button (Filled Button)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // TRIGGER THE SUCCESS SHEET HERE
                  SuccessBottomSheet(
                    title: "Thank you",
                    message: "Your Ride has been successfully Completed.",
                    buttonText: "Done",
                    onButtonPressed: () => Get.offAllNamed(Routes.MAIN),
                    iconColor: primaryGold,
                    backgroundColor: bgDark,
                    showHandle: false,
                  ).show(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGold,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Pay \$150",
                  style: TextStyle(
                    color: textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // --- Helper to build each row ---
  Widget _buildOptionItem(
    int index,
    String title,
    String subtitle,
    IconData icon,
  ) {
    bool isSelected = _selectedMethod == index;
    final Color primaryGold = R.theme.goldAccent;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedMethod = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.transparent, // Ensures hit test works
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(icon, color: primaryGold, size: 24),
            ),
            const SizedBox(width: 16),

            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Radio Indicator (Custom Design)
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primaryGold : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: R.theme.goldAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // --- 2. ADD CARD BOTTOM SHEET ---
  void _showAddCardBottomSheet(BuildContext context) {
    final Color primaryGold = R.theme.goldAccent;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(width: 40, height: 4, color: Colors.grey[700]),
              const SizedBox(height: 24),

              const Text(
                "Enter Card Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Card Fields
              _buildDarkTextField(
                "Card Number",
                "0000 0001 0002 0005",
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  CardNumberFormatter(),
                ],
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildDarkTextField(
                "Card Holder",
                "MacRaymond Idan",
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                ],
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDarkTextField(
                      "CVV",
                      "000",
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CvvFormatter(maxLength: 4),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDarkTextField(
                      "Expiry Date",
                      "02/26",
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        ExpiryDateFormatter(),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close sheet
                    SnackBarUtils.successMsg("Card Added!");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGold,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDarkTextField(
    String label,
    String hint, {
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            style: const TextStyle(color: Colors.amber),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.amber.withOpacity(0.5)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
