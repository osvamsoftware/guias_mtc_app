import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeColors {
  static const Color primaryRed = Color(0xFFBF0909);
  static const Color secondaryBlue = Color.fromARGB(255, 39, 181, 247);

  // static const Color brightOrange = Color(0xFF7ECEFF); //
  // static const Color lightGreen = Color(0xFF81C784); // Verde claro
  static const Color lightGrey = Color(0xFFF5F5F5); // Gris claro
  static const Color darkGrey = Color.fromARGB(255, 35, 35, 35); // Gris oscuro
  static const Color darkGreySecondary = Color.fromARGB(255, 46, 47, 46); // Gris oscuro
}

class CustomThemeData {
  final bool isDarkMode;
  final BuildContext context;

  CustomThemeData({required this.isDarkMode, required this.context});

  ThemeData getThemeData() {
    final newTextTheme = GoogleFonts.poppinsTextTheme().apply(
      bodyColor: isDarkMode ? ThemeColors.lightGrey : ThemeColors.darkGrey,
      displayColor: isDarkMode ? ThemeColors.lightGrey : ThemeColors.darkGrey,
    );

    return ThemeData(
      colorSchemeSeed: Colors.red,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      useMaterial3: true,
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: WidgetStateProperty.all<bool>(true),
        thumbColor: WidgetStateProperty.all(Colors.grey[500]),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.primaryRed,
              textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
      drawerTheme: DrawerThemeData(
        backgroundColor: isDarkMode ? ThemeColors.darkGrey : ThemeColors.lightGrey,
      ),
      // hintColor: ThemeColors.lightGreen,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(textStyle: const TextStyle(color: Colors.white)),
      ),
      textTheme: newTextTheme,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
        color: ThemeColors.primaryRed,
        centerTitle: true,
      ),
      scaffoldBackgroundColor: isDarkMode ? ThemeColors.darkGrey : ThemeColors.lightGrey,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isDarkMode ? ThemeColors.darkGrey : ThemeColors.lightGrey,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ThemeColors.primaryRed,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xCFCFCFCF),
      ),
    );
  }

  CustomThemeData copyWith({Color? colorSeed, bool? isDarkMode}) =>
      CustomThemeData(isDarkMode: isDarkMode ?? this.isDarkMode, context: context);
}

class CustomLightThemeData extends CustomThemeData {
  CustomLightThemeData(BuildContext context) : super(isDarkMode: false, context: context);
}

class CustomDarkThemeData extends CustomThemeData {
  CustomDarkThemeData(BuildContext context) : super(isDarkMode: true, context: context);
}
