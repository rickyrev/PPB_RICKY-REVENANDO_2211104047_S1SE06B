import 'package:flutter/material.dart';

class ColorSchemesView {
  // Definisi warna menggunakan kode hex
  static const Color lightGreen = Color(0xFFB5CA8D); // #b5ca8d
  static const Color mediumGreen = Color(0xFF8BB174); // #8bb174
  static const Color teal = Color(0xFF426B69); // #426b69
  static const Color darkBlue = Color(0xFF222E50); // #222e50
  static const Color darkTeal = Color(0xFF2A4849); // #2a4849

  // List palet warna
  static const List<Color> palette = [
    lightGreen,
    mediumGreen,
    teal,
    darkBlue,
    darkTeal,
  ];

  // Mengembalikan skema warna utama
  static ThemeData getTheme() {
    return ThemeData(
      primarySwatch: createMaterialColor(darkBlue), // Menggunakan warna biru gelap sebagai primary swatch
      scaffoldBackgroundColor: lightGreen, // Latar belakang menggunakan hijau muda
      textTheme: TextTheme(
        // Menggunakan TextStyle standar
        displayMedium: TextStyle(color: darkTeal), // Untuk judul
        bodyLarge: TextStyle(color: darkBlue), // Untuk teks utama
      ),
    );
  }

  // Metode untuk mendapatkan skema warna Material
  static MaterialColor createMaterialColor(Color color) {
    Map<int, Color> swatch = {
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color,
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    };
    return MaterialColor(color.value, swatch);
  }
}