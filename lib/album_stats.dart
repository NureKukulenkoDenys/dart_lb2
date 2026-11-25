import 'album.dart';

typedef AlbumStats = ({int count, int totalTracks, Duration totalDuration});

AlbumStats summarizeAlbums(Iterable<Album> albums) {
  var count = 0;
  var totalTracks = 0;
  var totalSeconds = 0;
  for (final album in albums) {
    count++;
    totalTracks += album.trackCount;
    totalSeconds += album.duration.inSeconds;
  }
  return (
    count: count,
    totalTracks: totalTracks,
    totalDuration: Duration(seconds: totalSeconds),
  );
}

String classifyAlbum(Album album) => switch (album) {
  Album(trackCount: >= 12, duration: final duration)
      when duration.inMinutes >= 45 =>
    'Розширений повноформатний альбом',
  Album(trackCount: >= 6) => 'Стандартний альбом',
  Album() => 'Мініальбом',
};
