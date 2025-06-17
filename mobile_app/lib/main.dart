import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/linkedin_colors.dart';
import 'providers/app_state.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.light(
      primary: LinkedInColors.primary,
      secondary: LinkedInColors.accent,
      background: LinkedInColors.background,
    );

    return MaterialApp(
      title: 'Power Monitor',
      theme: ThemeData(
        colorScheme: cs,
        primaryColor: LinkedInColors.primary,
        scaffoldBackgroundColor: LinkedInColors.background,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: LinkedInColors.textPrimary),
          bodyMedium: TextStyle(color: LinkedInColors.textSecondary),
          titleLarge: TextStyle(color: LinkedInColors.textPrimary, fontSize: 20),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
