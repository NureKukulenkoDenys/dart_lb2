import 'package:music_album_catalog/album.dart';

void main() {
  final album = Album(
    'Queen',
    'A Night at the Opera',
    1975,
    'EMI',
    12,
    const Duration(minutes: 43),
  );
  print(album);
}
