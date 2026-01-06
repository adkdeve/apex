import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import this package

class SearchingDriverDialog extends StatelessWidget {
  const SearchingDriverDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF0B0B0C),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Custom SVG Asset ---
            SvgPicture.asset(
              'assets/icons/search_dialog.svg', // Ensure this path matches your pubspec.yaml
              width: 120, // Adjust size as needed
              height: 120,
            ),

            const SizedBox(height: 30),

            // --- Text ---
            const Text(
              "Searching for Driver...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist',
              ),
            ),
          ],
        ),
      ),
    );
  }
}