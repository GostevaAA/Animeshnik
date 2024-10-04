import 'package:animeshnik/ui/colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData light({TargetPlatform? platform}) => _themeFromColorScheme(
        colorScheme: AppColors.lightScheme,
        platform: platform,
      );

  static ThemeData dark({TargetPlatform? platform}) => _themeFromColorScheme(
        colorScheme: AppColors.darkScheme,
        platform: platform,
      );

  /// Fork of [ThemeData.from] factory.
  /// Added optional override of [platform].
  static ThemeData _themeFromColorScheme({
    required ColorScheme colorScheme,
    TextTheme? textTheme,
    TargetPlatform? platform,
  }) {
    final isDark = colorScheme.brightness == Brightness.dark;

    // For surfaces that use primary color in light themes and surface color in dark
    final primarySurfaceColor =
        isDark ? colorScheme.surface : colorScheme.primary;
    final onPrimarySurfaceColor =
        isDark ? colorScheme.onSurface : colorScheme.onPrimary;

    return ThemeData(
      platform: platform,
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      primaryColor: primarySurfaceColor,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      cardColor: colorScheme.surface,
      dividerColor: colorScheme.onSurface.withOpacity(0.12),
      dialogBackgroundColor: colorScheme.surface,
      indicatorColor: onPrimarySurfaceColor,
      textTheme: textTheme,
      applyElevationOverlayColor: isDark,
      useMaterial3: true,

      // Override windows page transition
      // pageTransitionsTheme: const PageTransitionsTheme(
      //   builders: <TargetPlatform, PageTransitionsBuilder>{
      //     TargetPlatform.android: ZoomPageTransitionsBuilder(),
      //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      //     TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      //     TargetPlatform.windows: FadeThroughPageTransitionsBuilder(),
      //   },
      // ),

      // Components themes
      // dialogTheme: DialogTheme(
      //   backgroundColor: colorScheme.surfaceContainerHighest,
      // ),
      // cardTheme: const CardTheme(
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(16))),
      //   clipBehavior: Clip.hardEdge,
      // ),
      // snackBarTheme: const SnackBarThemeData(
      //   behavior: SnackBarBehavior.floating,
      // ),
    );
  }
}
