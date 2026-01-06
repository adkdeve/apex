// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:construction_safety/app/modules/auth/bindings/auth_binding.dart';
// import 'package:construction_safety/app/modules/auth/views/register_view.dart';
// import 'package:construction_safety/app/modules/auth/views/forget_password_view.dart';
//
// void main() {
//   testWidgets('RegisterView and ForgetPasswordView basic render', (
//     WidgetTester tester,
//   ) async {
//     await tester.pumpWidget(
//       GetMaterialApp(initialBinding: AuthBinding(), home: const RegisterView()),
//     );
//
//     expect(find.text('Register Now!'), findsOneWidget);
//     expect(find.text('Sign up'), findsOneWidget);
//
//     await tester.pumpWidget(
//       GetMaterialApp(
//         initialBinding: AuthBinding(),
//         home: const ForgetPasswordView(),
//       ),
//     );
//
//     expect(find.text('Forget Password!'), findsOneWidget);
//     expect(find.text('Send verification Link'), findsOneWidget);
//   });
// }
