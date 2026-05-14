import 'package:flutter/material.dart';

class KoadlyColors {
  const KoadlyColors._();

  static const orange = Color(0xffff5a16);
  static const orangeDark = Color(0xffe64908);
  static const black = Color(0xff171a20);
  static const ink = Color(0xff30343a);
  static const muted = Color(0xff6d7178);
  static const soft = Color(0xfffff7f2);
  static const line = Color(0xffece6e1);
  static const success = Color(0xff027a48);
}

class KoadlyTheme {
  const KoadlyTheme._();

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: KoadlyColors.orange,
      primary: KoadlyColors.orange,
      surface: Colors.white,
      onSurface: KoadlyColors.black,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: const Color(0xfffffbf8),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: KoadlyColors.black,
        centerTitle: false,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: KoadlyColors.orange,
          foregroundColor: Colors.white,
          minimumSize: const Size(64, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: KoadlyColors.black,
          side: const BorderSide(color: KoadlyColors.line),
          minimumSize: const Size(64, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        labelStyle: const TextStyle(color: KoadlyColors.muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: KoadlyColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: KoadlyColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: KoadlyColors.orange, width: 1.5),
        ),
      ),
    );
  }
}
