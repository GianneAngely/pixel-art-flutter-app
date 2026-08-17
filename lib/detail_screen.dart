import 'package:flutter/material.dart';

import 'models/pokemon.dart';
import 'services/pokemon_service.dart';
import 'utils/type_colors.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String name;

  const DetailScreen({super.key, required this.id, required this.name});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<PokemonDetail> _future;

  @override
  void initState() {
    super.initState();
    _future = PokemonService().fetchDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonDetail>(
      future: _future,
      builder: (context, snapshot) {
        final hasData = snapshot.hasData;
        final primaryType =
            hasData && snapshot.data!.types.isNotEmpty ? snapshot.data!.types.first : 'normal';
        final headerColor = colorForType(primaryType);

        return Scaffold(
          backgroundColor: headerColor,
          appBar: AppBar(
            backgroundColor: headerColor,
            foregroundColor: Colors.white,
            elevation: 0,
            title: Text(
              capitalize(widget.name),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : snapshot.hasError
                  ? const Center(
                      child: Text('Failed to load',
                          style: TextStyle(color: Colors.white)),
                    )
                  : _DetailBody(pokemon: snapshot.data!, headerColor: headerColor),
        );
      },
    );
  }
}

class _DetailBody extends StatelessWidget {
  final PokemonDetail pokemon;
  final Color headerColor;

  const _DetailBody({required this.pokemon, required this.headerColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          pokemon.dexNumber,
          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        Hero(
          tag: 'poke-${pokemon.id}',
          child: Image.network(
            pokemon.imageUrl,
            height: 200,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const SizedBox(
              height: 200,
              child: Icon(Icons.catching_pokemon, size: 80, color: Colors.white54),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    spacing: 8,
                    children:
                        pokemon.types.map((t) => _TypeChip(type: t)).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoTile(label: 'Height', value: '${pokemon.heightM} m'),
                      _InfoTile(label: 'Weight', value: '${pokemon.weightKg} kg'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Base Stats',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: headerColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...pokemon.stats.map((s) => _StatBar(stat: s, color: headerColor)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String type;

  const _TypeChip({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: colorForType(type),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        capitalize(type),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class _StatBar extends StatelessWidget {
  final StatEntry stat;
  final Color color;

  const _StatBar({required this.stat, required this.color});

  String get _label {
    switch (stat.name) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'ATK';
      case 'defense':
        return 'DEF';
      case 'special-attack':
        return 'SpA';
      case 'special-defense':
        return 'SpD';
      case 'speed':
        return 'SPD';
      default:
        return stat.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: Text(
              _label,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700),
            ),
          ),
          SizedBox(
            width: 34,
            child: Text('${stat.value}', textAlign: TextAlign.end),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: (stat.value / 180).clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor: color.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
