// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:construction_safety/common/widgets/otp_input.dart';
//
// void main() {
//   testWidgets('OTPInput renders correct number of fields and completes', (
//     WidgetTester tester,
//   ) async {
//     String? code;
//
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(body: OTPInput(length: 4, onCompleted: (c) => code = c)),
//       ),
//     );
//
//     expect(find.byKey(const Key('otp-field-0')), findsOneWidget);
//     expect(find.byKey(const Key('otp-field-3')), findsOneWidget);
//
//     await tester.enterText(find.byKey(const Key('otp-field-0')), '1');
//     await tester.pumpAndSettle();
//     await tester.enterText(find.byKey(const Key('otp-field-1')), '2');
//     await tester.pumpAndSettle();
//     await tester.enterText(find.byKey(const Key('otp-field-2')), '3');
//     await tester.pumpAndSettle();
//     await tester.enterText(find.byKey(const Key('otp-field-3')), '4');
//     await tester.pumpAndSettle();
//
//     expect(code, '1234');
//   });
// }
