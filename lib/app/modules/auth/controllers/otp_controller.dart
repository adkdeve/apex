import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  // Constants
  final int otpLength = 4;
  final int initialTimer = 54;

  // Text Controllers & Focus Nodes
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  // State Variables
  var timerValue = 54.obs;
  var canResend = false.obs;
  var isError = false.obs;
  var isSuccess = false.obs;
  var currentOtp = "".obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());

    startTimer();
  }

  void startTimer() {
    timerValue.value = initialTimer;
    canResend.value = false;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerValue.value <= 1) {
        canResend.value = true;
        timer.cancel();
      } else {
        timerValue.value--;
      }
    });
  }

  void onChanged(String value, int index) {
    isError.value = false;
    isSuccess.value = false;

    if (value.isNotEmpty) {
      if (index < otpLength - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    }
    _updateCurrentOtp();
  }

  void _updateCurrentOtp() {
    currentOtp.value = controllers.map((c) => c.text).join();
  }

  void handleConfirm(VoidCallback onVerify) {
    String code = controllers.map((c) => c.text).join();

    if (code.length != otpLength) return;

    if (code == '1234') {
      isError.value = false;
      isSuccess.value = true;

      Future.delayed(const Duration(milliseconds: 500), () {
        onVerify();
      });
    } else {
      isSuccess.value = false;
      isError.value = true;
      Future.delayed(const Duration(milliseconds: 1500), () {
        clearOtp();
        isError.value = false;
        focusNodes[0].requestFocus();
      });
    }
  }

  void handleResend() {
    if (!canResend.value) return;

    clearOtp();
    isError.value = false;
    startTimer();
    focusNodes[0].requestFocus();
    // Trigger API call here
    print("Resend code triggered");
  }

  void clearOtp() {
    for (var c in controllers) {
      c.clear();
    }
    isSuccess.value = false;
    _updateCurrentOtp();
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var c in controllers) { c.dispose(); }
    for (var f in focusNodes) { f.dispose(); }
    super.onClose();
  }

  String get formattedTime {
    int mins = timerValue.value ~/ 60;
    int secs = timerValue.value % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}