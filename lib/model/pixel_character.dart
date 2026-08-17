class PixelCharacter {
  String name;
  String gameSource;
  String description;
  String ability;
  String releaseYear;
  String imageAsset;
  List<String> imageUrls;

  PixelCharacter({
    required this.name,
    required this.gameSource,
    required this.description,
    required this.ability,
    required this.releaseYear,
    required this.imageAsset,
    required this.imageUrls,
  });
}

var pixelCharacterList = [
  PixelCharacter(
    name: 'Mario',
    gameSource: 'Super Mario Bros',
    description:
        'Mario adalah tukang ledeng berkumis ikonik dari Nintendo yang selalu berpetualang menyelamatkan Putri Peach dari Bowser di Kerajaan Jamur.',
    ability: 'Jumping, Fireball',
    releaseYear: '1985',
    imageAsset:
        'https://upload.wikimedia.org/wikipedia/en/a/a9/MarioNSMBUDeluxe.png',
    imageUrls: [
      'https://upload.wikimedia.org/wikipedia/en/a/a9/MarioNSMBUDeluxe.png',
      'https://upload.wikimedia.org/wikipedia/en/9/99/MarioSMBW.png',
      'https://upload.wikimedia.org/wikipedia/en/0/03/Super_Mario_Bros._box.png',
    ],
  ),
  PixelCharacter(
    name: 'Sonic',
    gameSource: 'Sonic the Hedgehog',
    description:
        'Landak biru super cepat yang menjadi maskot SEGA. Dia berjuang melawan Dr. Eggman untuk melindungi hewan-hewan dan Master Emerald.',
    ability: 'Super Speed, Spin Dash',
    releaseYear: '1991',
    imageAsset:
        'https://upload.wikimedia.org/wikipedia/en/2/21/Sonic_the_Hedgehog_character_artwork.png',
    imageUrls: [
      'https://upload.wikimedia.org/wikipedia/en/2/21/Sonic_the_Hedgehog_character_artwork.png',
      'https://upload.wikimedia.org/wikipedia/en/b/ba/Sonic_the_Hedgehog_1_Genesis_box_art.jpg',
    ],
  ),
  PixelCharacter(
    name: 'Link',
    gameSource: 'The Legend of Zelda',
    description:
        'Pahlawan berbaju hijau dari Hyrule yang memegang Master Sword. Tugas utamanya adalah menyelamatkan Putri Zelda dan mengalahkan Ganon.',
    ability: 'Swordsmanship, Archery',
    releaseYear: '1986',
    imageAsset:
        'https://upload.wikimedia.org/wikipedia/en/2/21/Link_of_the_Wild.png',
    imageUrls: [
      'https://upload.wikimedia.org/wikipedia/en/2/21/Link_of_the_Wild.png',
      'https://upload.wikimedia.org/wikipedia/en/c/c9/The_Legend_of_Zelda_NES.png',
    ],
  ),
  PixelCharacter(
    name: 'Mega Man',
    gameSource: 'Mega Man',
    description:
        'Robot tempur biru yang diciptakan oleh Dr. Light untuk menghentikan ambisi jahat Dr. Wily. Dia bisa menyalin senjata musuh yang dikalahkannya.',
    ability: 'Mega Buster, Copy Weapon',
    releaseYear: '1987',
    imageAsset:
        'https://upload.wikimedia.org/wikipedia/en/3/3e/Megaman_1987.png',
    imageUrls: [
      'https://upload.wikimedia.org/wikipedia/en/3/3e/Megaman_1987.png',
      'https://upload.wikimedia.org/wikipedia/en/4/46/Mega_Man_1_box_artwork.jpg',
    ],
  ),
  PixelCharacter(
    name: 'Pikachu',
    gameSource: 'Pokémon',
    description:
        'Pokémon tipe listrik yang paling terkenal dan merupakan partner setia Ash Ketchum. Pipi merahnya bisa mengeluarkan sengatan listrik kuat.',
    ability: 'Thunderbolt, Iron Tail',
    releaseYear: '1996',
    imageAsset:
        'https://upload.wikimedia.org/wikipedia/en/a/a6/Pokémon_Pikachu_art.png',
    imageUrls: [
      'https://upload.wikimedia.org/wikipedia/en/a/a6/Pokémon_Pikachu_art.png',
      'https://upload.wikimedia.org/wikipedia/en/3/39/Pok%C3%A9mon_Red_Version_Box_Art.jpg',
    ],
  ),
  PixelCharacter(
    name: 'Pac-Man',
    gameSource: 'Pac-Man',
    description:
        'Karakter berbentuk bulat kuning yang hobi makan titik-titik (pellet) dan dikejar-kejar oleh empat hantu di dalam labirin neon.',
    ability: 'Eating, Chomp',
    releaseYear: '1980',
    imageAsset:
        'https://upload.wikimedia.org/wikipedia/en/5/59/Pac-man.png',
    imageUrls: [
      'https://upload.wikimedia.org/wikipedia/en/5/59/Pac-man.png',
      'https://upload.wikimedia.org/wikipedia/en/0/03/PacManArcade.png',
    ],
  ),
  PixelCharacter(
    name: 'Donkey Kong',
    gameSource: 'Donkey Kong',
    description:
        'Gorila besar berdasi merah yang suka melempar tong. Awalnya musuh Mario, tapi sekarang menjadi pahlawan di pulaunya sendiri.',
    ability: 'Super Strength, Barrel Throw',
    releaseYear: '1981',
    imageAsset:
        'https://upload.wikimedia.org/wikipedia/en/1/14/Donkey_Kong_Country.png',
    imageUrls: [
      'https://upload.wikimedia.org/wikipedia/en/1/14/Donkey_Kong_Country.png',
      'https://upload.wikimedia.org/wikipedia/en/c/c9/Donkey_Kong_Country_Returns_Box_Art.jpg',
    ],
  ),
  PixelCharacter(
    name: 'Kirby',
    gameSource: 'Kirby\'s Dream Land',
    description:
        'Bola merah muda yang imut tapi mematikan. Dia bisa menghisap musuh dan menelan mereka untuk menyalin kekuatan unik mereka.',
    ability: 'Inhale, Copy Ability',
    releaseYear: '1992',
    imageAsset:
        'https://upload.wikimedia.org/wikipedia/en/2/22/Kirby_Wii.png',
    imageUrls: [
      'https://upload.wikimedia.org/wikipedia/en/2/22/Kirby_Wii.png',
      'https://upload.wikimedia.org/wikipedia/en/f/f0/Kirby_Dream_Land_Box_Art.jpg',
    ],
  ),
  PixelCharacter(
    name: 'Ryu',
    gameSource: 'Street Fighter',
    description:
        'Seniman bela diri pengelana yang mendedikasikan hidupnya untuk latihan. Jurus "Hadouken" miliknya dikenal di seluruh dunia.',
    ability: 'Hadouken, Shoryuken',
    releaseYear: '1987',
    imageAsset:
        'https://upload.wikimedia.org/wikipedia/en/e/e5/Ryu_TvC.png',
    imageUrls: [
      'https://upload.wikimedia.org/wikipedia/en/e/e5/Ryu_TvC.png',
      'https://upload.wikimedia.org/wikipedia/en/1/1d/SF2_JPN_flyer.jpg',
    ],
  ),
  PixelCharacter(
    name: 'Cloud Strife',
    gameSource: 'Final Fantasy VII',
    description:
        'Seorang mantan prajurit dengan pedang besar (Buster Sword). Karakter ikonik RPG yang berjuang menyelamatkan planet dari Sephiroth.',
    ability: 'Limit Break, Omnislash',
    releaseYear: '1997',
    imageAsset:
        'https://upload.wikimedia.org/wikipedia/en/a/a5/Cloud_Strife.png',
    imageUrls: [
      'https://upload.wikimedia.org/wikipedia/en/a/a5/Cloud_Strife.png',
      'https://upload.wikimedia.org/wikipedia/en/c/c2/Final_Fantasy_VII_Box_Art.jpg',
    ],
  ),
];