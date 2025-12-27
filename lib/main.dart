import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tourist_guide/core/global/theme/theme_data/theme_data_dark.dart';
import 'package:tourist_guide/core/global/theme/theme_data/theme_data_light.dart';
import 'package:tourist_guide/core/providers/auth_provider.dart';
import 'package:tourist_guide/core/providers/favorites_provider.dart';
import 'package:tourist_guide/core/providers/places_provider.dart';
import 'package:tourist_guide/core/providers/theme_provider.dart';
import 'package:tourist_guide/featuers/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://meodjttfrjpastkzxukc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1lb2RqdHRmcmpwYXN0a3p4dWtjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI3ODY0NzAsImV4cCI6MjA3ODM2MjQ3MH0.o_krl1ea8SI9z5DPIwM16SORxxZN0Yed_UFnCYdLpVA',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider للثيم (يجب أن يكون أولاً)
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        // Provider للمصادقة
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        // Provider للأماكن السياحية
        ChangeNotifierProvider(create: (_) => PlacesProvider()),

        // Provider للمفضلات
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Tourist Guide',
            theme: getThemeDataLight(),
            darkTheme: getThemeDataDark(),
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
