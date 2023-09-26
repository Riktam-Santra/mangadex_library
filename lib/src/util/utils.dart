import '../models/search/search.dart';

abstract class Utils {
  /// Uses [baseUrl], [chapterHash] and [filename]
  /// and returns a [String] containing the full constructed address to the page
  /// base url can be obtained from the [getBaseUrl] function, the token using the login() function
  /// chapterHash and filename can both be obtained via [getChapterDataByChapterId]
  String constructPageUrl(
      String baseUrl, bool dataSaver, String chapterHash, String filename) {
    var dataMode = dataSaver ? 'data-saver' : 'data';
    return '$baseUrl/$dataMode/$chapterHash/$filename';
  }

  static List<String> constructCoverPageUrl(Map<String, String> map) {
    return [
      for (final mangaId in map.keys)
        'https://uploads.mangadex.org/covers/$mangaId/${map[mangaId]}'
    ];
  }

  /// Note this function only gives a Map of the manga ids mapped to their cover filenames.
  /// You must use constructPageUrl() in utils and pass the map to it to get the urls.

  static Map<String, String> getCoverArtUrlMap(Search searchData) {
    var map = <String, String>{};

    for (final manga in searchData.data!) {
      final searchVal = manga.relationships
          ?.where((element) => element.attributes != null)
          .toList();
      map.addEntries(
        [
          MapEntry(manga.id!, searchVal![0].attributes!.fileName!),
        ],
      );
    }
    if (map.isEmpty) {
      print('''
The generated URL map seems to be empty, if this wasn't what you wanted,
please make sure that the includes parameter included 'cover_art' as it's value.

That is search(includes: ['cover_art'])
''');
    }

    return map;
  }
}
