sealed class AlbumEdition {
  const AlbumEdition();

  String describe();
}

mixin PlaylistBadge on AlbumEdition {
  String get playlistBadge => '[PLAY] ${describe()}';
}

final class StudioEdition extends AlbumEdition with PlaylistBadge {
  const StudioEdition();

  @override
  String describe() => 'Студійний запис';
}

final class LiveEdition extends AlbumEdition with PlaylistBadge {
  const LiveEdition(this.venue);

  final String venue;

  @override
  String describe() => 'Концертний запис: $venue';
}

final class RemasteredEdition extends AlbumEdition {
  const RemasteredEdition(this.year);

  final int year;

  @override
  String describe() => 'Ремастер $year';
}

final class CompilationEdition extends AlbumEdition {
  const CompilationEdition(this.sourceAlbumCount);

  final int sourceAlbumCount;

  @override
  String describe() => 'Збірка з $sourceAlbumCount альбомів';
}

String editionKind(AlbumEdition edition) => switch (edition) {
  StudioEdition() => 'studio',
  LiveEdition(venue: final venue) => 'live ($venue)',
  RemasteredEdition(year: final year) => 'remaster ($year)',
  CompilationEdition(sourceAlbumCount: final count) => 'compilation ($count)',
  PlaylistBadge() => 'playlist',
};
