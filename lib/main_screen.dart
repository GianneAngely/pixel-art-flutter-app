import 'package:flutter/material.dart';
import 'package:submission_pixel_art/detail_screen.dart';
import 'package:submission_pixel_art/model/pixel_character.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF34495E),
      appBar: AppBar(
        title: const Text('Pixel Art Gallery 👾'),
        backgroundColor: const Color(0xFF2C3E50),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
               Navigator.pushNamed(context, '/about');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final PixelCharacter character = pixelCharacterList[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailScreen(character: character);
                }));
              },
              child: Card(
                color: const Color(0xFFECF0F1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          character.imageAsset, 
                          fit: BoxFit.contain,
                          // INI PENYELAMATNYA:
                          errorBuilder: (ctx, error, stackTrace) {
                            return const Center(child: Icon(Icons.error, color: Colors.red));
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              character.name,
                              style: const TextStyle(
                                fontSize: 18.0, 
                                fontWeight: FontWeight.bold,
                                color: Colors.black87
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              character.gameSource,
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: pixelCharacterList.length,
        ),
      ),
    );
  }
}