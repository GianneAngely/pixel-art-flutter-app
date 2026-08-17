import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDC0A2D),
        foregroundColor: Colors.white,
        title: const Text('About'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.catching_pokemon, size: 80, color: Color(0xFFDC0A2D)),
              const SizedBox(height: 16),
              const Text('Pokédex',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                'A Flutter app that browses Pokémon using the free PokéAPI — '
                'a grid gallery with each Pokémon\'s types and base stats.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, height: 1.4),
              ),
              const SizedBox(height: 24),
              const Text('Built with Flutter · PokéAPI',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              const Text('by GianneAngely', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
