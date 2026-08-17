# Flutter Pokédex

A Pokédex built with **Flutter**, powered live by the free [PokéAPI](https://pokeapi.co) — browse Pokémon in a grid, then tap any one for its types and base stats.

**🔗 Live demo → [flutter-pokedex-six.vercel.app](https://flutter-pokedex-six.vercel.app)**

<p align="center">
  <img src="screenshots/home.png" width="760" alt="Pokédex home screen: a grid of Pokémon cards with official artwork and Dex numbers">
</p>
<p align="center">
  <img src="screenshots/detail.png" width="380" alt="Bulbasaur detail screen: type chips, height and weight, and base stat bars">
</p>

## Features

- **Live data** from the PokéAPI — official artwork, types, height/weight, and base stats.
- **Grid gallery** of Pokémon with their National Dex numbers.
- **Detail view** with a type-coloured header, type chips, and base-stat bars.
- Graceful **loading and error states**, with retry on failure.

## How it's built

- `lib/models/` — `PokemonSummary` and `PokemonDetail` data classes.
- `lib/services/pokemon_service.dart` — a small typed client over the PokéAPI.
- `lib/utils/type_colors.dart` — the canonical Pokémon type colours.
- `lib/main_screen.dart` (grid) and `lib/detail_screen.dart` (details).

## Run it

```bash
flutter pub get
flutter run -d chrome   # or any device / emulator
```

## Tech stack

Flutter · Dart · http · PokéAPI · Material 3
