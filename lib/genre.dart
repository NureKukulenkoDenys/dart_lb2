enum MusicGenre {
  rock('Рок', 3),

  jazz('Джаз', 2),

  electronic('Електронна музика', 4);

  const MusicGenre(this.displayName, this.discoveryWeight);

  final String displayName;

  final int discoveryWeight;

  String get recommendation => '$displayName: вага $discoveryWeight';
}
