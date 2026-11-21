import 'identifiable.dart';

const int minReleaseYear = 1900;

const int maxReleaseYear = 2100;

final class Album(
  final String artist,
  final String title,
  final int year,
  final String label,
  final int trackCount,
  final Duration duration,
) implements Identifiable {
  this {
    if (artist.trim().isEmpty || title.trim().isEmpty || label.trim().isEmpty) {
      throw ArgumentError('Artist, title and label must not be empty.');
    }
    if (year < minReleaseYear || year > maxReleaseYear) {
      throw RangeError.range(year, minReleaseYear, maxReleaseYear, 'year');
    }
    if (trackCount <= 0 || duration.inSeconds <= 0) {
      throw ArgumentError('Tracks and duration must be positive.');
    }
  }

  static final Album _unknown = Album(
    'Unknown',
    'Unknown album',
    2000,
    'Unknown label',
    1,
    const Duration(minutes: 1),
  );

  factory Album.fromCsv(String line) {
    final fields = line.split(';').map((value) => value.trim()).toList();
    if (fields.length != 6) {
      throw const FormatException('Expected six fields separated by ;');
    }
    final year = int.tryParse(fields[2]);
    final tracks = int.tryParse(fields[4]);
    final minutes = int.tryParse(fields[5]);
    if (year == null || tracks == null || minutes == null) {
      throw const FormatException('Year, track count and minutes must be integers.');
    }
    return Album(
      fields[0],
      fields[1],
      year,
      fields[3],
      tracks,
      Duration(minutes: minutes),
    );
  }

  factory Album.unknown() => _unknown;

  @override
  String get id => '${artist.toLowerCase()}::${title.toLowerCase()}::$year';

  Duration get averageTrackDuration =>
      Duration(seconds: duration.inSeconds ~/ trackCount);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Album &&
          artist == other.artist &&
          title == other.title &&
          year == other.year &&
          label == other.label &&
          trackCount == other.trackCount &&
          duration == other.duration;

  @override
  int get hashCode =>
      Object.hash(artist, title, year, label, trackCount, duration);

  @override
  String toString() =>
      '$artist — $title ($year), $trackCount tracks, ${duration.inMinutes} min';
}
