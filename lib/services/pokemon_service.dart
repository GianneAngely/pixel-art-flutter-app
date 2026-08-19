import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

/// Thin client over the public PokéAPI (https://pokeapi.co).
class PokemonService {
  static const String _base = 'https://pokeapi.co/api/v2';

  /// Fetches the first [limit] Pokémon as lightweight summaries.
  Future<List<PokemonSummary>> fetchList({int limit = 30}) async {
    final res = await http.get(Uri.parse('$_base/pokemon?limit=$limit&offset=0'));
    if (res.statusCode != 200) {
      throw Exception('Failed to load Pokédex (HTTP ${res.statusCode})');
    }
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final results = data['results'] as List;
    return results.map((r) {
      final url = r['url'] as String; // e.g. https://pokeapi.co/api/v2/pokemon/1/
      final id = int.parse(
        url.split('/').where((s) => s.isNotEmpty).last,
      );
      return PokemonSummary(id: id, name: r['name'] as String);
    }).toList();
  }

  /// Fetches the first [limit] Pokémon with full detail (types, stats, size),
  /// so the grid can render type-coloured cards. Details load concurrently.
  Future<List<PokemonDetail>> fetchListDetailed({int limit = 30}) async {
    final summaries = await fetchList(limit: limit);
    return Future.wait(summaries.map((s) => fetchDetail(s.id)));
  }

  /// Fetches full detail (types, stats, size) for one Pokémon.
  Future<PokemonDetail> fetchDetail(int id) async {
    final res = await http.get(Uri.parse('$_base/pokemon/$id'));
    if (res.statusCode != 200) {
      throw Exception('Failed to load Pokémon #$id (HTTP ${res.statusCode})');
    }
    return PokemonDetail.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }
}
