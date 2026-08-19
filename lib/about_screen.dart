import 'package:flutter/material.dart';

import 'utils/type_colors.dart';

const _kBrand = Color(0xFFDC0A2D);

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_kBrand, darken(_kBrand, 0.14)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: -30,
                right: -34,
                child: Icon(Icons.catching_pokemon,
                    size: 200, color: Colors.white.withValues(alpha: 0.10)),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.catching_pokemon,
                            size: 64, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      const Text('Pokédex',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          )),
                      const SizedBox(height: 12),
                      const Text(
                        'A Flutter app that browses Pokémon live from the free '
                        'PokéAPI — a type-coloured grid, search, and a detail '
                        'view with base stats.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white70, height: 1.5, fontSize: 14),
                      ),
                      const SizedBox(height: 26),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text('Built with Flutter · PokéAPI',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, color: _kBrand)),
                      ),
                      const SizedBox(height: 12),
                      const Text('by GianneAngely',
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
