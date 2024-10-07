import 'package:animeshnik/presentation/home/home_screen.dart';
import 'package:animeshnik/ui/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const HomeScreen());
    //home: const TitleUpdatesScreen());
  }
}
