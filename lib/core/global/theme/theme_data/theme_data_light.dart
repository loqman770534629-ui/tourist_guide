import 'package:flutter/material.dart';
import 'package:tourist_guide/core/global/theme/app_color/app_color_light.dart';

/// ثيم الوضع النهاري مع تدرجات الأزرق
ThemeData getThemeDataLight() => ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColorLight.primaryColor,
      colorScheme: const ColorScheme.light(
        primary: AppColorLight.primaryColor,
        secondary: AppColorLight.secondaryColor,
        surface: AppColorLight.cardbackground,
        background: AppColorLight.scaffoldbackground,
        error: Color(0xFFEF4444),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColorLight.text,
        onBackground: AppColorLight.text,
        onError: Colors.white,
      ),
      
      // شريط التطبيق
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColorLight.appBarColor,
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
            AppColorLight.backgroundelevatedButton,
          ),
          foregroundColor: const WidgetStatePropertyAll<Color?>(
            AppColorLight.textElevatedButton,
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
              const WidgetStatePropertyAll<Color?>(AppColorLight.accentBlue),
        ),
      ),
      
      // زر الإجراء العائم
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColorLight.floatingActionButton,
        foregroundColor: Colors.white,
      ),
      
      // الخلفية
      scaffoldBackgroundColor: AppColorLight.scaffoldbackground,
      
      // البطاقات
      cardTheme: CardThemeData(
        color: AppColorLight.cardbackground,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: AppColorLight.borderColor,
            width: 0.5,
          ),
        ),
      ),
      
      // شريط التنقل السفلي
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColorLight.bottomnavigationbarcolor,
        selectedItemColor: AppColorLight.primaryColor,
        unselectedItemColor: AppColorLight.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // الأيقونات
      iconTheme: const IconThemeData(
        color: AppColorLight.primaryColor,
      ),
      
      // النصوص
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColorLight.text,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: AppColorLight.text,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: AppColorLight.text,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColorLight.text,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: AppColorLight.text,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: AppColorLight.text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColorLight.text,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColorLight.text,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: AppColorLight.textSecondary,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: AppColorLight.text,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // الفواصل
      dividerColor: AppColorLight.dividerColor,
      dividerTheme: const DividerThemeData(
        color: AppColorLight.dividerColor,
        thickness: 1,
      ),
      
      // حقول الإدخال
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColorLight.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColorLight.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColorLight.primaryColor,
            width: 2,
          ),
        ),
        labelStyle: const TextStyle(color: AppColorLight.textSecondary),
        hintStyle: const TextStyle(color: AppColorLight.textTertiary),
      ),
      
      // الحوارات
      dialogTheme: DialogThemeData(
        backgroundColor: AppColorLight.cardbackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: AppColorLight.lightBlue,
        selectedColor: AppColorLight.primaryColor,
        labelStyle: const TextStyle(color: AppColorLight.text),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide.none,
        ),
      ),
      
      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColorLight.primaryColor;
          }
          return AppColorLight.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColorLight.primaryColor.withOpacity(0.5);
          }
          return AppColorLight.borderColor;
        }),
      ),
    );
