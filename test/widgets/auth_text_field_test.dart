// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:construction_safety/common/widgets/auth_text_field.dart';
// import 'package:flutter/widgets.dart';
//
// void main() {
//   testWidgets('AuthTextField renders label, hint and container border', (
//     WidgetTester tester,
//   ) async {
//     final controller = TextEditingController();
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: AuthTextField(
//               label: 'Email Address',
//               hint: 'your email address',
//               controller: controller,
//             ),
//           ),
//         ),
//       ),
//     );
//
//     // Verify label is present
//     expect(find.text('Email Address'), findsOneWidget);
//
//     // Verify hint string is present in the field
//     expect(find.text('your email address'), findsOneWidget);
//
//     // Verify container decoration exists and has the expected border
//     final container = tester.widget<Container>(
//       find.byKey(const Key('auth-field-container')),
//     );
//     final boxDec = container.decoration as BoxDecoration?;
//     expect(boxDec?.border, isNotNull);
//     expect((boxDec?.border as Border?)?.top.color, isNotNull);
//   });
// }
