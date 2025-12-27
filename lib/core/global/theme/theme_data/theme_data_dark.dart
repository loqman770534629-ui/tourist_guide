import 'package:flutter/material.dart';
import 'package:tourist_guide/core/global/theme/app_color/app_color_dark.dart';

/// ثيم الوضع الليلي مع تدرجات الأزرق
ThemeData getThemeDataDark() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColorDark.primaryColor,
      colorScheme: const ColorScheme.dark(
        primary: AppColorDark.primaryColor,
        secondary: AppColorDark.secondaryColor,
        surface: AppColorDark.cardbackground,
        background: AppColorDark.scaffoldbackground,
        error: Color(0xFFFF6B6B),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColorDark.text,
        onBackground: AppColorDark.text,
        onError: Colors.white,
      ),
      
      // شريط التطبيق
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColorDark.appBarColor,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
      ),
      
      // الأزرار المرتفعة
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll<Color?>(
            AppColorDark.backgroundelevatedButton,
          ),
          foregroundColor: const WidgetStatePropertyAll<Color?>(
            AppColorDark.textElevatedButton,
          ),
          elevation: const WidgetStatePropertyAll<double>(2),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      
      // الأزرار النصية
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              const WidgetStatePropertyAll<Color?>(AppColorDark.accentBlue),
        ),
      ),
      
      // زر الإجراء العائم
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColorDark.floatingActionButton,
        foregroundColor: Colors.white,
      ),
      
      // الخلفية
      scaffoldBackgroundColor: AppColorDark.scaffoldbackground,
      
      // البطاقات
      cardTheme: CardThemeData(
        color: AppColorDark.cardbackground,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: AppColorDark.borderColor,
            width: 1,
          ),
        ),
      ),
      
      // شريط التنقل السفلي
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColorDark.bottomnavigationbarcolor,
        selectedItemColor: AppColorDark.accentBlue,
        unselectedItemColor: AppColorDark.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // الأيقونات
      iconTheme: const IconThemeData(
        color: AppColorDark.primaryColor,
      ),
      
      // النصوص
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColorDark.text,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: AppColorDark.text,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: AppColorDark.text,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColorDark.text,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: AppColorDark.text,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: AppColorDark.text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColorDark.text,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColorDark.text,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: AppColorDark.textSecondary,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: AppColorDark.text,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // الفواصل
      dividerColor: AppColorDark.dividerColor,
      dividerTheme: const DividerThemeData(
        color: AppColorDark.dividerColor,
        thickness: 1,
      ),
      
      // حقول الإدخال
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorDark.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColorDark.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColorDark.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColorDark.accentBlue,
            width: 2,
          ),
        ),
        labelStyle: const TextStyle(color: AppColorDark.textSecondary),
        hintStyle: const TextStyle(color: AppColorDark.textTertiary),
      ),
      
      // الحوارات
      dialogTheme: DialogThemeData(
        backgroundColor: AppColorDark.cardbackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: AppColorDark.surfaceColor,
        selectedColor: AppColorDark.primaryColor,
        labelStyle: const TextStyle(color: AppColorDark.text),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColorDark.borderColor),
        ),
      ),
      
      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColorDark.accentBlue;
          }
          return AppColorDark.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColorDark.accentBlue.withOpacity(0.5);
          }
          return AppColorDark.borderColor;
        }),
      ),
    );
