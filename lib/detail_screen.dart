import 'package:flutter/material.dart';
import 'package:submission_pixel_art/model/pixel_character.dart';

class DetailScreen extends StatelessWidget {
  final PixelCharacter character;

  const DetailScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.white,
                    child: Image.network(
                      character.imageAsset,
                      fit: BoxFit.contain,
                      // PENYELAMAT CRASH:
                      errorBuilder: (ctx, error, stackTrace) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.broken_image, size: 50, color: Colors.grey),
                              Text("Gagal memuat gambar", style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          const FavoriteButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Text(
                  character.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monospace',
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const Icon(Icons.videogame_asset, color: Colors.greenAccent),
                        const SizedBox(height: 8.0),
                        Text(
                          character.gameSource,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Icon(Icons.calendar_today, color: Colors.greenAccent),
                        const SizedBox(height: 8.0),
                        Text(
                          character.releaseYear,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  character.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
                 child: Text(
                   "Ability: ${character.ability}",
                   textAlign: TextAlign.center,
                   style: const TextStyle(
                     fontSize: 18.0,
                     fontWeight: FontWeight.bold,
                     color: Colors.yellowAccent,
                   ),
                 ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: character.imageUrls.map((url) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.white,
                          child: Image.network(
                            url,
                            errorBuilder: (ctx, error, stackTrace) {
                              return const Icon(Icons.error, color: Colors.red);
                            },
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black54,
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
      ),
    );
  }
}