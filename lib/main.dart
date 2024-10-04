import 'package:animeshnik/title_updates_screen.dart';
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
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(
        //       seedColor: const Color(0xFFFED900), brightness: Brightness.dark),
        //   useMaterial3: true,
        // ),
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const TitleUpdatesScreen());
  }
}
