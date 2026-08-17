import 'package:flutter/material.dart';

import 'about_screen.dart';
import 'main_screen.dart';

void main() => runApp(const PokedexApp());

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFDC0A2D),
        scaffoldBackgroundColor: const Color(0xFFF6F7F9),
      ),
      home: const MainScreen(),
      routes: {
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
