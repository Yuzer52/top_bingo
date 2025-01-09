import 'package:flutter/material.dart';

class AppTheme {
  static const Color darkBlue = Color.fromARGB(255, 13, 14, 65);
  static const Color dark = Color(0xFF000000);
  static const Color meduiumGery = Color(0x50FFFFFF);
  static const Color accent = Color.fromARGB(255, 24, 90, 235);
  static const Color light = Color(0xFFFFFFFF);

  static const Color disabledBackgroundColor = Color.fromARGB(31, 97, 97, 97);
  static const Color disabledForegroundColor =
      Color.fromARGB(255, 255, 255, 255);

  static const TextStyle bingoStyle = TextStyle(
    color: light,
    fontSize: 60,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle fancyStyle = TextStyle(
    color: light,
    fontSize: 60,
    fontFamily: 'Bungee',
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w200,
  );
  static const TextStyle numberStyle = TextStyle(
    color: meduiumGery,
    fontSize: 60,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle numberStyleToggled = TextStyle(
    color: light,
    fontSize: 60,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle darkStyle = TextStyle(
    color: dark,
    fontSize: 60,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w500,
  );

  static const Color primaryColor = Color(0xFF36853D);
  static const Color accentColor = Color(0xFF3F51B5);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF333333);
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
    hintColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.green,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    hintColor: Colors.purpleAccent,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      color: Colors.deepPurple,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );

  static bool _isDarkMode = false;

  static bool get isDarkMode => _isDarkMode;

  static void toggleTheme(bool value) {
    _isDarkMode = !_isDarkMode;
    // Notify listeners or update app state here
  }
}
