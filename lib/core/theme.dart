import 'package:flutter/material.dart';

const gramnotaGreen = Color(0xFF0F6E56);

/// Lighter brand green for marks that sit on a dark surface.
const gramnotaGreenBright = Color(0xFF3DDC97);

const _paper = Color(0xFFF6F3EC);
const _ink = Color(0xFF1A1F1C);
const _cardLine = Color(0xFFE4DDD2);

const _night = Color(0xFF141A17);
const _nightCard = Color(0xFF1E2823);
const _nightRaised = Color(0xFF24302A);
const _nightInk = Color(0xFFF4F7F5);
const _nightMuted = Color(0xFFC5D1CB);
const _nightLine = Color(0xFF3A4A43);

ThemeData buildGramnotaTheme({Brightness brightness = Brightness.light}) {
  final dark = brightness == Brightness.dark;
  final scheme = dark
      ? ColorScheme.fromSeed(
          seedColor: gramnotaGreen,
          brightness: Brightness.dark,
        ).copyWith(
          // Bright green is the primary text and icon color on night
          // surfaces. Filled buttons keep the darker brand green below.
          primary: gramnotaGreenBright,
          onPrimary: const Color(0xFF04281C),
          primaryContainer: const Color(0xFF1F4A3C),
          onPrimaryContainer: const Color(0xFFE7F8F1),
          secondary: const Color(0xFFA9C7B8),
          onSecondary: const Color(0xFF10241C),
          tertiary: const Color(0xFFE2C27A),
          onTertiary: const Color(0xFF2A2108),
          surface: _night,
          onSurface: _nightInk,
          onSurfaceVariant: _nightMuted,
          surfaceContainerLowest: _nightCard,
          surfaceContainerLow: _nightCard,
          surfaceContainer: _nightRaised,
          surfaceContainerHigh: _nightRaised,
          outline: const Color(0xFF8AA097),
          outlineVariant: _nightLine,
          error: const Color(0xFFFFB4AB),
          onError: const Color(0xFF690005),
          inverseSurface: const Color(0xFFE7EEE9),
          onInverseSurface: _ink,
        )
      : ColorScheme.fromSeed(
          seedColor: gramnotaGreen,
          brightness: Brightness.light,
        ).copyWith(
          primary: gramnotaGreen,
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFD7EFE6),
          onPrimaryContainer: const Color(0xFF07382C),
          surface: _paper,
          onSurface: _ink,
          surfaceContainerLowest: Colors.white,
          surfaceContainerLow: Colors.white,
          surfaceContainer: const Color(0xFFEFEBE3),
          outline: const Color(0xFFD5D0C6),
          outlineVariant: _cardLine,
        );
  final paper = dark ? _night : _paper;
  final ink = dark ? _nightInk : _ink;
  final card = dark ? _nightCard : Colors.white;
  final line = dark ? _nightLine : _cardLine;
  final selectedLabel = dark ? gramnotaGreenBright : gramnotaGreen;
  const radius = 16.0;
  final shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
    side: BorderSide(color: line),
  );
  final fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: scheme.outlineVariant),
  );
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    scaffoldBackgroundColor: paper,
    dividerColor: line,
    canvasColor: paper,
    appBarTheme: AppBarTheme(
      backgroundColor: paper,
      foregroundColor: ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: card,
      surfaceTintColor: Colors.transparent,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: card,
      surfaceTintColor: Colors.transparent,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: scheme.inverseSurface,
      contentTextStyle: TextStyle(color: scheme.onInverseSurface),
      // The bar is the inverse surface: light in dark mode, dark in light mode.
      actionTextColor: dark ? gramnotaGreen : gramnotaGreenBright,
      behavior: SnackBarBehavior.floating,
    ),
    cardTheme: CardThemeData(
      color: card,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: shape,
      margin: EdgeInsets.zero,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: card,
      elevation: 0,
      height: 72,
      indicatorColor: scheme.primaryContainer,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          size: 24,
          color: selected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return TextStyle(
          fontSize: 12,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          color: selected ? selectedLabel : scheme.onSurfaceVariant,
        );
      }),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: card,
      indicatorColor: scheme.primaryContainer,
      selectedIconTheme: IconThemeData(color: scheme.onPrimaryContainer),
      unselectedIconTheme: IconThemeData(color: scheme.onSurfaceVariant),
      selectedLabelTextStyle: TextStyle(
        color: selectedLabel,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: scheme.onSurfaceVariant,
        fontSize: 12,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: card,
      border: fieldBorder,
      enabledBorder: fieldBorder,
      focusedBorder: fieldBorder.copyWith(
        borderSide: BorderSide(
          color: dark ? gramnotaGreenBright : gramnotaGreen,
          width: 1.6,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      // Narrow fields (grams beside the spool) otherwise ellipsize the error.
      errorMaxLines: 3,
      helperMaxLines: 3,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: gramnotaGreen,
        foregroundColor: Colors.white,
        minimumSize: const Size(48, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: dark ? gramnotaGreenBright : gramnotaGreen,
        minimumSize: const Size(48, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: dark ? gramnotaGreenBright : gramnotaGreen,
        minimumSize: const Size(48, 48),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: card,
      selectedColor: scheme.primaryContainer,
      side: BorderSide(color: scheme.outlineVariant),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      labelStyle: TextStyle(color: scheme.onSurface),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: gramnotaGreen,
      foregroundColor: Colors.white,
      elevation: 1,
    ),
  );
}
