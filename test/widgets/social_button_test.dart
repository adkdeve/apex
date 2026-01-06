// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:construction_safety/common/widgets/social_button.dart';
//
// void main() {
//   testWidgets('SocialButton renders label and responds to tap', (
//     WidgetTester tester,
//   ) async {
//     var tapped = false;
//
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: Center(
//             child: SocialButton(
//               label: 'Google',
//               iconData: Icons.g_mobiledata,
//               onPressed: () {
//                 tapped = true;
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//
//     expect(find.text('Google'), findsOneWidget);
//     expect(find.byKey(const Key('social-button')), findsOneWidget);
//
//     await tester.tap(find.byKey(const Key('social-button')));
//     await tester.pumpAndSettle();
//
//     expect(tapped, isTrue);
//   });
// }
