import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static final AppThemeData _instance = AppThemeData._internal();

  factory AppThemeData() {
    return _instance;
  }

  AppThemeData._internal();

  // Defined colors directly within the AppThemeData class
  final Color primary = Color(0xffC8A74E);
  final Color secondary = Color(0xFFC8A74E);
  final Color white = Colors.white;
  final Color black = Colors.black;
  final Color grey = Colors.grey;
  final Color yellow = Colors.yellow;
  final Color green = Color(0xff0A6375);
  final Color transparent = Colors.transparent;

  // Frequently used greys
  final Color color400 = Color(0xff94A3B8);
  final Color color600 = Color(0xff475569);
  final Color textGrey = Color(0xFF9CA3AF);
  final Color subTextGrey = Color(0xFF6F6F6F);
  final Color greyText = Color(0xFF8E8E93);

  // Error Colors
  final Color error = Colors.redAccent;
  final Color errorColor = Color(0xFFff6b6b);
  final Color errorBg = Color.fromRGBO(255, 107, 107, 0.05);

  // Gold/Primary variants
  final Color goldBg = Color.fromRGBO(212, 175, 55, 0.05);
  final Color goldAccent = Color(0xFFCFA854);

  // Button Colors
  final Color disableBtnBck = Color(0xffECECEC);
  final Color disableBtntext = Color.fromRGBO(4, 12, 34, 0.40);

  // Input/Border Colors
  final Color borderFocused = Color(0xffF87171);
  final Color borderUnfocused = Color(0xffCBD5E1);
  final Color cursorColor = Color(0xff0C192B);
  final Color inputBorder = Color(0xffE3E3E3);
  final double inputBorderRadius = 8.0;
  final Color inputPlaceholder = Color(0xffC9C9C9);

  // Dark Theme Colors
  final Color darkBackground = const Color(0xFF0B0B0C);
  final Color cardBg = const Color(0xFF262626);

  final Color cardBgVariant = const Color(0xFF1E1E1E);

  // Driver Module Colors (consolidated to avoid duplicates)
  final Color driverBackground = const Color(
    0xFF121212,
  ); // Slightly lighter than pure black
  // Using goldAccent instead of separate driverGoldColor
  // Using cardBgVariant instead of driverCardColor and driverInputColor
  final Color driverGreenColor = const Color(0xFF66BB6A); // Success/active
  final Color driverRedColor = const Color(0xFFEF5350); // Warning/danger
  final Color driverOrangeColor = const Color(0xFFFFA726); // Alert
  final Color driverBlueColor = const Color(0xFF42A5F5); // Info
  final Color driverGreyText = const Color(0xFF9E9E9E); // Secondary text
  final Color driverBorderColor = const Color(
    0xFF333333,
  ); // Border/divider color (consolidated)
  final Color driverButtonBg = const Color(0xFF2C2C2C); // Button background
  final Color driverFrameColor = const Color(0xFFD9D9D9); // Frame/placeholder
  final Color driverGreyBackground = const Color(0xFF757575); // Grey background
  final Color driverDarkCard = const Color(0xFF252525); // Dark card variant

  // Box Decoration Color
  static Color lightBoxDecorationColor = Color(0xFFECEFF1);
  static Color darkBoxDecorationColor = Color(0xFF1E1E1E);

  bool isDarkMode = false;

  void applySystemUIOverlayStyle(ThemeMode themeMode) {
    if (isDarkMode =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      );
    }
  }

  // Light Theme
  ThemeData get light {
    final base = ThemeData.light();
    final colorScheme = ColorScheme.light(
      primary: primary,
      secondary: secondary,
      background: white,
      surface: white,
      onPrimary: white,
      onSecondary: black,
      onBackground: textGrey,
      onSurface: textGrey,
      error: error,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.background,
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: white,
        foregroundColor: black,
      ),
      bottomAppBarTheme: base.bottomAppBarTheme.copyWith(color: primary),
      // bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      //   backgroundColor: orange,
      // ),
      textTheme: base.textTheme.copyWith(
        bodyLarge: base.textTheme.bodyLarge!.copyWith(
          color: colorScheme.onBackground,
        ),
        labelLarge: base.textTheme.labelLarge!.copyWith(
          color: colorScheme.onPrimary,
        ),
      ),

      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: colorScheme.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      iconTheme: base.iconTheme.copyWith(color: colorScheme.onBackground),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        hintStyle: GoogleFonts.inter(color: color400),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: colorScheme.secondary),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: colorScheme.primary),
        // ),
        errorStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.redAccent, // or your custom color
          height: 1.2, // controls vertical spacing
        ),
        // errorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: colorScheme.error),
        // ),
        labelStyle: TextStyle(color: colorScheme.onSurface),
      ),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: colorScheme.primary,
      ),
      snackBarTheme: base.snackBarTheme.copyWith(
        backgroundColor: colorScheme.primary,
      ),
      textSelectionTheme: base.textSelectionTheme.copyWith(
        selectionColor: secondary,
        cursorColor: primary,
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        backgroundColor: white,
        selectedItemColor: green,
        unselectedItemColor: black,
      ),
      // switchTheme: SwitchThemeData(
      //   thumbColor: WidgetStateProperty.all(switchInactiveThumbColor),
      //   trackColor: WidgetStateProperty.all(switchInactiveTrackColor),
      //   activeTrackColor: WidgetStateProperty.all(switchActiveTrackColor),
      //   activeColor: WidgetStateProperty.all(switchActiveColor),
      // ),
      //
    );
  }
}
