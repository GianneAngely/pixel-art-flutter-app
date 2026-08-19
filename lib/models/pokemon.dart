// Data models for the Pokédex, populated from the PokéAPI.

String _artwork(int id) =>
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

String _dex(int id) => '#${id.toString().padLeft(3, '0')}';

/// Lightweight entry used for the grid — just enough to render a card.
class PokemonSummary {
  final int id;
  final String name;

  PokemonSummary({required this.id, required this.name});

  String get imageUrl => _artwork(id);
  String get dexNumber => _dex(id);
}

class StatEntry {
  final String name;
  final int value;

  StatEntry(this.name, this.value);
}

/// Full detail for a single Pokémon.
class PokemonDetail {
  final int id;
  final String name;
  final List<String> types;
  final int heightDm; // decimetres
  final int weightHg; // hectograms
  final List<StatEntry> stats;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.types,
    required this.heightDm,
    required this.weightHg,
    required this.stats,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      types: (json['types'] as List)
          .map((t) => (t['type']['name'] as String))
          .toList(),
      heightDm: json['height'] as int,
      weightHg: json['weight'] as int,
      stats: (json['stats'] as List)
          .map((s) => StatEntry(
                s['stat']['name'] as String,
                s['base_stat'] as int,
              ))
          .toList(),
    );
  }

  String get imageUrl => _artwork(id);
  String get dexNumber => _dex(id);
  double get heightM => heightDm / 10.0;
  double get weightKg => weightHg / 10.0;
  String get primaryType => types.isNotEmpty ? types.first : 'normal';
  int get statTotal => stats.fold(0, (sum, s) => sum + s.value);
}
