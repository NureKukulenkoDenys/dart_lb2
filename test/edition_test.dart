import 'package:music_album_catalog/edition.dart';
import 'package:music_album_catalog/genre.dart';
import 'package:test/test.dart';

void main() {
  test('sealed switch handles all four edition subtypes', () {
    expect(editionKind(const StudioEdition()), 'studio');
    expect(editionKind(const LiveEdition('Київ')), 'live (Київ)');
    expect(editionKind(const RemasteredEdition(2011)), 'remaster (2011)');
    expect(editionKind(const CompilationEdition(3)), 'compilation (3)');
  });

  test('selective mixin adds a playlist badge to studio and live', () {
    expect(const StudioEdition().playlistBadge, contains('PLAY'));
    expect(const LiveEdition('Київ').playlistBadge, contains('PLAY'));
  });

  test('enhanced enum has fields and behaviour', () {
    expect(MusicGenre.rock.displayName, 'Рок');
    expect(MusicGenre.rock.recommendation, contains('вага'));
  });
}
