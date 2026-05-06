import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'db/database_helper.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initApp();

  runApp(const NegocioProApp());
}

/// 🔥 Inicialización centralizada (más limpio y escalable)
Future<void> _initApp() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await DatabaseHelper.instance.database;
}

/// 🌐 Navigator global (útil para navegación desde cualquier lugar)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NegocioProApp extends StatelessWidget {
  const NegocioProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Negocio PRO',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: AppTheme.dark(),
      home: const SplashScreen(),
    );
  }
}

/// 🎨 Tema separado (más ordenado y profesional)
class AppTheme {
  static ThemeData dark() {
    const primary = Color(0xFF00C853);
    const background = Color(0xFF0A0A0A);
    const surface = Color(0xFF121212);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: Color(0xFF69F0AE),
        surface: surface,
      ),

      scaffoldBackgroundColor: background,
      fontFamily: 'Roboto',

      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),

      cardTheme: CardTheme(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white12),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
