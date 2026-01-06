import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'app/data/services/auth_service.dart';
import 'app/routes/app_pages.dart';
import 'app/core/core.dart';
import 'binding/app_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Force close keyboard on launch immediately (Optional specific fix)
  SystemChannels.textInput.invokeMethod('TextInput.hide');

  // Initialize AuthService before runApp
  final authService = AuthService();

  // Retrieve stored data
  final key = await authService.getToken();

  // Decide initial route
  final String initialRoute = (key != null && key.isNotEmpty)
      ? AppPages.INITIAL
      : AppPages.INITIAL;

  runApp(
    ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: AppConfig.appName,
            initialBinding: AppBinding(),
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              // 1. Initialize EasyLoading
              child = EasyLoading.init()(context, child);

              // 2. Wrap with GestureDetector to close keyboard globally
              return GestureDetector(
                behavior: HitTestBehavior.opaque, // Ensures taps on empty space are caught
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: child,
              );
            },
            defaultTransition: Transition.rightToLeft,
            // Localization
            translations: MyAppTranslation(),
            locale: AppConfig.defaultLocale,
            fallbackLocale: AppConfig.defaultLocale,
            supportedLocales: MyAppTranslation.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            // Theme
            themeMode: AppConfig.appDefaultTheme,
            theme: R.theme.light,
            // End
            initialRoute: initialRoute,
            getPages: AppPages.routes,
          );
        }),
  );
}
