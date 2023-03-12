import 'models/search/search.dart';

abstract class Utils {
  static List<String> constructCoverPageUrl(Map<String, String> map) {
    return [
      for (final mangaId in map.keys)
        'https://uploads.mangadex.org/covers/$mangaId/${map[mangaId]}'
    ];
  }

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
    print('''
Note this function only gives a Map of the manga ids mapped to their cover filenames.
You must use constructPageUrl() in utils and pass the map to it to get the urls. ''');

    return map;
  }
}
