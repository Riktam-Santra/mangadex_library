class Utils {
  static List<String> constructCoverPageUrl(Map<String, String> map) {
    return [
      for (final mangaId in map.keys)
        'https://uploads.mangadex.org/covers/$mangaId/${map[mangaId]}'
    ];
  }
}
