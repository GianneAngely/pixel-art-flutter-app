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
        final data = snapshot.data;
        final type = data != null && data.types.isNotEmpty
            ? data.types.first
            : 'normal';
        final colors = data != null
            ? gradientForType(type)
            : const [Color(0xFFBFC7D2), Color(0xFF9AA4B2)];

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
            ),
            child: SafeArea(
              child: snapshot.connectionState == ConnectionState.waiting
                  ? _Loading(name: widget.name)
                  : snapshot.hasError || data == null
                      ? _DetailError(name: widget.name)
                      : _DetailBody(pokemon: data),
            ),
          ),
        );
      },
    );
  }
}

class _Loading extends StatelessWidget {
  final String name;
  const _Loading({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBar(name: name, dex: ''),
        const Expanded(
          child: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _DetailError extends StatelessWidget {
  final String name;
  const _DetailError({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBar(name: name, dex: ''),
        const Expanded(
          child: Center(
            child: Text("Couldn't load this Pokémon.",
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  final String name;
  final String dex;
  const _TopBar({required this.name, required this.dex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 6, 16, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            capitalize(name),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          if (dex.isNotEmpty)
            Text(
              dex,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
        ],
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  final PokemonDetail pokemon;
  const _DetailBody({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final base = colorForType(pokemon.primaryType);
    return Stack(
      children: [
        Positioned(
          top: 30,
          right: -28,
          child: Icon(
            Icons.catching_pokemon,
            size: 190,
            color: Colors.white.withValues(alpha: 0.16),
          ),
        ),
        Column(
          children: [
            _TopBar(name: pokemon.name, dex: pokemon.dexNumber),
            const SizedBox(height: 6),
            Hero(
              tag: 'poke-${pokemon.id}',
              child: Image.network(
                pokemon.imageUrl,
                height: 200,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const SizedBox(
                  height: 200,
                  child: Icon(Icons.catching_pokemon,
                      size: 90, color: Colors.white54),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFFAFBFD),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 10,
                        children: pokemon.types
                            .map((t) => _TypeChip(type: t))
                            .toList(),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Expanded(
                            child: _InfoTile(
                              icon: Icons.straighten,
                              label: 'Height',
                              value: '${pokemon.heightM} m',
                              color: base,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _InfoTile(
                              icon: Icons.monitor_weight_outlined,
                              label: 'Weight',
                              value: '${pokemon.weightKg} kg',
                              color: base,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      Row(
                        children: [
                          Text(
                            'Base Stats',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: base,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Total ${pokemon.statTotal}',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      ...pokemon.stats.map(
                        (s) => _StatBar(stat: s, color: base),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
    final c = colorForType(type);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: c.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        capitalize(type),
        style: TextStyle(
            color: onColor(c), fontWeight: FontWeight.w700, fontSize: 13),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ],
      ),
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
        return stat.name.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    final fraction = (stat.value / 180).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: Text(
              _label,
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: Colors.grey.shade600),
            ),
          ),
          SizedBox(
            width: 34,
            child: Text('${stat.value}',
                textAlign: TextAlign.end,
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: 9,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: fraction),
                      duration: const Duration(milliseconds: 750),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, _) => Container(
                        height: 9,
                        width: constraints.maxWidth * value,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
