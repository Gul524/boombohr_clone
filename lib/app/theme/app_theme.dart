import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF16A34A); // bamboo green
  static const Color primaryExtraLight = Color.fromARGB(255, 115, 212, 150); // bamboo green
  static const Color primaryLight = Color.fromARGB(255, 89, 223, 138); // bamboo green
  static const Color primaryDim = Color.fromARGB(72, 89, 223, 138); // bamboo green
  static const Color scondary = Color.fromARGB(255, 250, 250, 250);  
  static const Color surface = Color(0xFFF6F7F9);  

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        surface: surface,
        onSurface: Colors.black,
        onPrimary: Colors.white,
        seedColor: primary, brightness: Brightness.light,),
      scaffoldBackgroundColor:Colors.white,
      dividerColor: Colors.grey,
      hintColor: Colors.grey,
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom()),
    );
  }

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.dark),
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
    );
  }
}
