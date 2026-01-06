// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:construction_safety/common/widgets/checkbox_tile.dart';
//
// void main() {
//   testWidgets('CheckboxTile toggles value on tap', (WidgetTester tester) async {
//     var value = false;
//
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: Center(
//             child: CheckboxTile(
//               value: value,
//               label: 'Remember me',
//               onChanged: (v) => value = v,
//             ),
//           ),
//         ),
//       ),
//     );
//
//     expect(find.text('Remember me'), findsOneWidget);
//
//     await tester.tap(find.byType(CheckboxTile));
//     await tester.pumpAndSettle();
//
//     expect(value, isTrue);
//   });
// }
