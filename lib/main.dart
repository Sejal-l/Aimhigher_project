import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aimhigher_app/screens/splash_screen.dart';
import 'package:aimhigher_app/screens/home_screen.dart';
import 'package:aimhigher_app/screens/login_screen.dart';
import 'package:aimhigher_app/screens/register_screen.dart';
import 'package:aimhigher_app/screens/edit_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isDarkMode = prefs.getBool('is_dark_mode') ?? false;

  runApp(AimHigherApp(initialDarkMode: isDarkMode));
}

class AimHigherApp extends StatefulWidget {
  final bool initialDarkMode;
  const AimHigherApp({super.key, required this.initialDarkMode});

  @override
  State<AimHigherApp> createState() => AimHigherAppState();

  static AimHigherAppState of(BuildContext context) =>
      context.findAncestorStateOfType<AimHigherAppState>()!;
}

class AimHigherAppState extends State<AimHigherApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme(bool isOn) async {
    setState(() {
      _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark_mode', isOn);
  }

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AimHigher',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3949AB),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF3949AB),
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3949AB),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
      },
    );
  }
}
