import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the color palette based on the design
    const backgroundColor = Color(0xFF121212); // Very dark grey background
    const goldColor = Color(0xFFD4AF37); // Gold for user bubbles and buttons
    const driverBubbleColor = Color(0xFF1F1F1F); // Dark grey for driver bubbles
    const inputFieldColor = Color(
      0xFF2C2C2E,
    ); // Slightly lighter grey for input
    const whiteColor = Colors.white;
    final greyTextColor = R.theme.greyText;
    const blackColor = Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            backgroundColor: whiteColor,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: blackColor,
                size: 18,
              ),
              onPressed: () {
                // Handle back navigation
              },
            ),
          ),
        ),
        title: const Text(
          'Chat',
          style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: goldColor),
            onPressed: () {
              // Handle phone call action
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Driver Profile Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    'assets/ben_stroke.png',
                  ), // Replace with your image asset
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ben Stroke',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Wed 8:21 AM',
                  style: TextStyle(color: R.theme.greyText, fontSize: 14),
                ),
              ],
            ),
          ),
          // Chat Messages List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: const [
                DriverMessageBubble(
                  message: 'Hello, I’m your driver! I’m on my way.',
                  avatarAsset:
                      'assets/driver_avatar_small.png', // Replace with asset
                  color: driverBubbleColor,
                  textColor: whiteColor,
                ),
                DriverMessageBubble(
                  message: 'Where are you?',
                  avatarAsset:
                      'assets/driver_avatar_small.png', // Replace with asset
                  color: driverBubbleColor,
                  textColor: whiteColor,
                ),
                UserMessageBubble(
                  message: 'Okay',
                  color: goldColor,
                  textColor: blackColor,
                ),
                UserMessageBubble(
                  message: 'I’m near the super market',
                  color: goldColor,
                  textColor: blackColor,
                ),
                DriverMessageBubble(
                  message: 'Hold on. I will be there in 5 minutes.',
                  avatarAsset:
                      'assets/driver_avatar_small.png', // Replace with asset
                  color: driverBubbleColor,
                  textColor: whiteColor,
                ),
                UserMessageBubble(
                  message: 'Alright, Thank you.',
                  color: goldColor,
                  textColor: blackColor,
                ),
              ],
            ),
          ),
          // Input Area
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            color: backgroundColor,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: inputFieldColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      style: const TextStyle(color: whiteColor),
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: greyTextColor),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: goldColor,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: whiteColor),
                    onPressed: () {
                      // Handle send message action
                    },
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

class DriverMessageBubble extends StatelessWidget {
  final String message;
  final String avatarAsset;
  final Color color;
  final Color textColor;

  const DriverMessageBubble({
    super.key,
    required this.message,
    required this.avatarAsset,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(radius: 16, backgroundImage: AssetImage(avatarAsset)),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(
                    4,
                  ), // Subtle corner for the sender
                ),
              ),
              child: Text(
                message,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
          ),
          // Add an empty SizedBox to prevent the bubble from stretching full width
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

class UserMessageBubble extends StatelessWidget {
  final String message;
  final Color color;
  final Color textColor;

  const UserMessageBubble({
    super.key,
    required this.message,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Add an empty SizedBox to prevent the bubble from stretching full width
          const SizedBox(width: 40),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(
                    4,
                  ), // Subtle corner for the sender
                ),
              ),
              child: Text(
                message,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
