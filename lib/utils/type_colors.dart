import 'package:flutter/material.dart';

/// Canonical colours for each Pokémon type.
const Map<String, Color> pokemonTypeColors = {
  'normal': Color(0xFFA8A878),
  'fire': Color(0xFFF08030),
  'water': Color(0xFF6890F0),
  'electric': Color(0xFFF8D030),
  'grass': Color(0xFF78C850),
  'ice': Color(0xFF98D8D8),
  'fighting': Color(0xFFC03028),
  'poison': Color(0xFFA040A0),
  'ground': Color(0xFFE0C068),
  'flying': Color(0xFFA890F0),
  'psychic': Color(0xFFF85888),
  'bug': Color(0xFFA8B820),
  'rock': Color(0xFFB8A038),
  'ghost': Color(0xFF705898),
  'dragon': Color(0xFF7038F8),
  'dark': Color(0xFF705848),
  'steel': Color(0xFFB8B8D0),
  'fairy': Color(0xFFEE99AC),
};

Color colorForType(String type) =>
    pokemonTypeColors[type] ?? const Color(0xFF8A8A8A);

/// A slightly darker shade of a colour, for gradients and accents.
Color darken(Color c, [double amount = 0.14]) {
  final hsl = HSLColor.fromColor(c);
  return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
}

/// A soft two-stop gradient for a type (light top-left → richer bottom-right).
List<Color> gradientForType(String type) {
  final base = colorForType(type);
  return [Color.lerp(base, Colors.white, 0.22)!, darken(base, 0.06)];
}

/// A readable foreground colour on top of [c].
Color onColor(Color c) =>
    ThemeData.estimateBrightnessForColor(c) == Brightness.dark
        ? Colors.white
        : const Color(0xFF23233B);

String capitalize(String s) =>
    s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
