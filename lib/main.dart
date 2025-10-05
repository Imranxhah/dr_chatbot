import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'config/app_constants.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const DrChatbotApp());
}

class DrChatbotApp extends StatelessWidget {
  const DrChatbotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Change to ThemeMode.system for auto theme
      home: const WelcomeScreen(),
    );
  }
}
