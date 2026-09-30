import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const NavGesturesApp());
}

class NavGesturesApp extends StatelessWidget {
  const NavGesturesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation & Gestures',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
        // We handle '/detail' via onGenerateRoute to pass arguments.
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final args = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) => DetailScreen(data: args ?? 'No Data'),
          );
        }
        return null;
      },
    );
  }
}
