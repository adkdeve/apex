// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:construction_safety/app/modules/auth/controllers/auth_controller.dart';
// import 'package:construction_safety/app/modules/auth/views/otp_view.dart';
//
// void main() {
//   setUp(() {
//     Get.testMode = true;
//   });
//
//   testWidgets('Resend button disabled when timer > 0', (
//     WidgetTester tester,
//   ) async {
//     final controller = AuthController();
//     Get.put(controller);
//
//     await tester.pumpWidget(GetMaterialApp(home: OTPView()));
//
//     // Start with timer > 0
//     controller.otpTimer.value = 10;
//     await tester.pumpAndSettle();
//
//     final btnFinder = find.widgetWithText(TextButton, 'Resend code');
//     expect(btnFinder, findsOneWidget);
//
//     final TextButton btn = tester.widget(btnFinder);
//     expect(btn.onPressed, isNull);
//   });
//
//   testWidgets('Entering OTP triggers verification and shows snackbar', (
//     WidgetTester tester,
//   ) async {
//     final controller = AuthController();
//     Get.put(controller);
//
//     await tester.pumpWidget(GetMaterialApp(home: OTPView()));
//
//     // Enter 4 digits
//     await tester.enterText(find.byKey(const Key('otp-field-0')), '1');
//     await tester.pump();
//     await tester.enterText(find.byKey(const Key('otp-field-1')), '2');
//     await tester.pump();
//     await tester.enterText(find.byKey(const Key('otp-field-2')), '3');
//     await tester.pump();
//     await tester.enterText(find.byKey(const Key('otp-field-3')), '4');
//
//     // Let the verification delay pass
//     await tester.pump(const Duration(milliseconds: 600));
//     await tester.pumpAndSettle();
//     // Allow snackbar timers to finish (Get.snackbar uses timers)
//     await tester.pump(const Duration(seconds: 4));
//
//     expect(find.text('OTP Verified'), findsOneWidget);
//     expect(controller.isLoading.value, isFalse);
//   });
// }
