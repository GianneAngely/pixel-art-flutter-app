import 'package:flutter/material.dart';

import 'detail_screen.dart';
import 'models/pokemon.dart';
import 'services/pokemon_service.dart';
import 'utils/type_colors.dart';

const kBrand = Color(0xFFDC0A2D);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PokemonService _service = PokemonService();
  late Future<List<PokemonDetail>> _future;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _future = _service.fetchListDetailed(limit: 40);
  }

  void _reload() {
    setState(() => _future = _service.fetchListDetailed(limit: 40));
  }

  List<PokemonDetail> _filter(List<PokemonDetail> all) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return all;
    return all
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.dexNumber.contains(q) ||
            p.id.toString() == q)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _Header(onSearch: (q) => setState(() => _query = q)),
          Expanded(
            child: FutureBuilder<List<PokemonDetail>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const _SkeletonGrid();
                }
                if (snapshot.hasError) {
                  return _ErrorView(onRetry: _reload);
                }
                final list = _filter(snapshot.data ?? []);
                if (list.isEmpty) return const _EmptyView();
                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(14, 16, 14, 24),
                  gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.82,
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, i) => _PokemonCard(pokemon: list[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ValueChanged<String> onSearch;

  const _Header({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kBrand, darken(kBrand, 0.12)],
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: kBrand.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: -26,
              right: -22,
              child: Icon(
                Icons.catching_pokemon,
                size: 150,
                color: Colors.white.withValues(alpha: 0.10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 12, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.catching_pokemon,
                          color: Colors.white, size: 30),
                      const SizedBox(width: 10),
                      const Text(
                        'Pokédex',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        tooltip: 'About',
                        icon: const Icon(Icons.info_outline,
                            color: Colors.white),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/about'),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 2, bottom: 14),
                    child: Text(
                      'Search for a Pokémon by name or number',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ),
                  _SearchField(onChanged: onSearch),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(16),
      child: TextField(
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'e.g. Pikachu or 025',
          prefixIcon: const Icon(Icons.search, color: kBrand),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _PokemonCard extends StatelessWidget {
  final PokemonDetail pokemon;

  const _PokemonCard({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final base = colorForType(pokemon.primaryType);
    final fg = onColor(base);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientForType(pokemon.primaryType),
        ),
        boxShadow: [
          BoxShadow(
            color: base.withValues(alpha: 0.42),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  DetailScreen(id: pokemon.id, name: pokemon.name),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -18,
                bottom: -20,
                child: Icon(
                  Icons.catching_pokemon,
                  size: 108,
                  color: Colors.white.withValues(alpha: 0.16),
                ),
              ),
              Positioned(
                top: 12,
                right: 14,
                child: Text(
                  pokemon.dexNumber,
                  style: TextStyle(
                    color: fg.withValues(alpha: 0.55),
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        child: Hero(
                          tag: 'poke-${pokemon.id}',
                          child: Image.network(
                            pokemon.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.catching_pokemon,
                              size: 44,
                              color: fg.withValues(alpha: 0.3),
                            ),
                            loadingBuilder: (context, child, progress) =>
                                progress == null
                                    ? child
                                    : Center(
                                        child: SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: fg.withValues(alpha: 0.6),
                                          ),
                                        ),
                                      ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      capitalize(pokemon.name),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: fg,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: pokemon.types
                          .take(2)
                          .map((t) => Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: _TypeTag(label: capitalize(t), fg: fg),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TypeTag extends StatelessWidget {
  final String label;
  final Color fg;

  const _TypeTag({required this.label, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: fg == Colors.white
            ? Colors.white.withValues(alpha: 0.25)
            : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: fg, fontWeight: FontWeight.w700, fontSize: 11),
      ),
    );
  }
}

class _SkeletonGrid extends StatefulWidget {
  const _SkeletonGrid();

  @override
  State<_SkeletonGrid> createState() => _SkeletonGridState();
}

class _SkeletonGridState extends State<_SkeletonGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))
        ..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 24),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.82,
      ),
      itemCount: 8,
      itemBuilder: (context, i) => AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final t = (_c.value + i * 0.12) % 1.0;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                begin: Alignment(-1 - 2 * (1 - t), 0),
                end: Alignment(1 - 2 * (1 - t), 0),
                colors: const [
                  Color(0xFFE7EAF0),
                  Color(0xFFF3F5F9),
                  Color(0xFFE7EAF0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 52, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text('No Pokémon found',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          const Text("Couldn't reach the Pokédex."),
          const SizedBox(height: 12),
          FilledButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
