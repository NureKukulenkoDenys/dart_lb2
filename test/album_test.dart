import 'package:music_album_catalog/album.dart';
import 'package:music_album_catalog/album_extensions.dart';
import 'package:test/test.dart';

void main() {
  const csv = 'Nirvana;Nevermind;1991;DGC;12;49';

  test('fromCsv parses all six fields', () {
    final album = Album.fromCsv(csv);
    expect(album.artist, 'Nirvana');
    expect(album.year, 1991);
    expect(album.trackCount, 12);
    expect(album.duration, const Duration(minutes: 49));
  });

  test('fromCsv rejects incorrect columns and non-integer values', () {
    expect(() => Album.fromCsv('bad;row'), throwsFormatException);
    expect(
      () => Album.fromCsv('Nirvana;Nevermind;year;DGC;12;49'),
      throwsFormatException,
    );
  });

  test('primary constructor validates domain values', () {
    expect(
      () => Album('A', 'B', 1800, 'C', 1, const Duration(minutes: 2)),
      throwsRangeError,
    );
  });

  test('value equality and matching hashCode deduplicate Set', () {
    final a = Album.fromCsv(csv);
    final b = Album.fromCsv(csv);
    expect(a, b);
    expect(a.hashCode, b.hashCode);
    expect(<Album>{a, b}.length, 1);
  });

  test('fallback factory returns a cached instance', () {
    expect(identical(Album.unknown(), Album.unknown()), isTrue);
  });

  test('computed duration per track is correct', () {
    expect(Album.fromCsv(csv).averageTrackDuration.inSeconds, 245);
  });

  test('extension removes redundant spaces', () {
    expect('  The   Wall  '.asCatalogTitle, 'The Wall');
  });
}
