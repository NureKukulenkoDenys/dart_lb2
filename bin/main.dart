import 'package:music_album_catalog/album.dart';
import 'package:music_album_catalog/album_extensions.dart';
import 'package:music_album_catalog/album_stats.dart';
import 'package:music_album_catalog/edition.dart';
import 'package:music_album_catalog/genre.dart';
import 'package:music_album_catalog/repository.dart';

void main() {
  const source = <String>[
    'Pink Floyd;The Dark Side of the Moon;1973;Harvest;10;43',
    'Nirvana;Nevermind;1991;DGC;12;49',
    'Daft Punk;Discovery;2001;Virgin;14;60',
  ];

  final catalog = Repository<Album>();
  for (final line in source) {
    catalog.add(Album.fromCsv(line));
  }

  for (final album in catalog.all) {
    print(album);
    print('Класифікація: ${classifyAlbum(album)}');
    print('Трек у середньому: ${album.averageTrackDuration.inSeconds} с');
  }

  final (:count, :totalTracks, :totalDuration) = summarizeAlbums(catalog.all);
  print('Альбомів: $count; треків: $totalTracks');
  print('Загальна тривалість: ${totalDuration.inMinutes} хв');

  final filtered = catalog.where((album) => album.year >= 1990);
  print('Після 1990 року: ${filtered.length}');
  print('Назва: ${'  The   Wall  '.asCatalogTitle}');
  print('Жанр: ${MusicGenre.rock.recommendation}');

  final editions = <AlbumEdition>[
    const StudioEdition(),
    const LiveEdition('Київ'),
    const RemasteredEdition(2011),
    const CompilationEdition(3),
  ];
  for (final edition in editions) {
    print('${edition.describe()} => ${editionKind(edition)}');
    if (edition is PlaylistBadge) {
      print(edition.playlistBadge);
    }
  }

  final first = Album.fromCsv(source.first);
  final second = Album.fromCsv(source.first);
  print('Два однакові об’єкти в Set: ${<Album>{first, second}.length}');
  print('Кешований fallback: ${identical(Album.unknown(), Album.unknown())}');
}
