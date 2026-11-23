extension AlbumTitleTools on String {
  String get asCatalogTitle => trim().replaceAll(RegExp(r'\s+'), ' ');
}
