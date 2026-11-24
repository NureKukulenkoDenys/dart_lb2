import 'package:music_album_catalog/album.dart';
import 'package:music_album_catalog/album_stats.dart';
import 'package:music_album_catalog/repository.dart';
import 'package:test/test.dart';

void main() {
  const csv = 'Nirvana;Nevermind;1991;DGC;12;49';

  test('Repository<Album> supports typed lookup and filtering', () {
    final repository = Repository<Album>();
    final album = Album.fromCsv(csv);
    repository.add(album);
    expect(repository.findById(album.id), same(album));
    expect(repository.where((entry) => entry.year < 2000).length, 1);
    expect(repository.findById('missing'), isNull);
    expect(repository.all.length, 1);
  });

  test('records and guarded object patterns give expected values', () {
    final albums = <Album>[
      Album.fromCsv(csv),
      Album.fromCsv('Queen;A Night at the Opera;1975;EMI;12;43'),
    ];
    final (:count, :totalTracks, :totalDuration) = summarizeAlbums(albums);
    expect(count, 2);
    expect(totalTracks, 24);
    expect(totalDuration.inMinutes, 92);
    expect(classifyAlbum(albums.first), 'Розширений повноформатний альбом');
    expect(classifyAlbum(albums.last), 'Стандартний альбом');
  });
}
