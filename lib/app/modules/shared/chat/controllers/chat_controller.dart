import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apex/app/data/models/chat_message_model.dart';

class ChatController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Observable list of messages
  var messages = <ChatMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load initial dummy messages
    messages.addAll(
      [
        ChatMessage(
          text: "I'm waiting at the corner.",
          isSender: false,
          time: "10:23 AM",
        ),
        ChatMessage(
          text: "Okay, I see you. I'm coming down.",
          isSender: true,
          time: "10:24 AM",
        ),
      ].reversed,
    ); // Reverse so oldest is at the top of the list logic (bottom of screen)
  }

  void sendMessage() {
    String text = textController.text.trim();
    if (text.isEmpty) return;

    // 1. Add User Message
    messages.insert(
      0,
      ChatMessage(text: text, isSender: true, time: _getCurrentTime()),
    );

    textController.clear();

    // 2. Simulate Driver Reply (Delayed)
    Future.delayed(const Duration(seconds: 1), () {
      messages.insert(
        0,
        ChatMessage(
          text: "Got it! See you soon.",
          isSender: false,
          time: _getCurrentTime(),
        ),
      );
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
