import 'dart:convert';

import 'package:mangadex_library/chapter/ChapterData.dart' as chapter;
import 'package:http/http.dart' as http;
import 'package:mangadex_library/search/Search.dart' as search;

class JsonSearch {
  var authority = 'api.mangadex.org';
  Future<List<String>> getChapterFilenames(
      String chapterId, bool isDataSaverMode) async {
    var response = await getChapterDataByChapterId(chapterId);
    if (isDataSaverMode == true) {
      return response.data.attributes.chapterDataSaver;
    } else {
      return response.data.attributes.chapterData;
    }
  }

  Future<chapter.Result> getChapterDataByChapterId(String chapterId) async {
    var unencodedPath = '/chapter/$chapterId';
    var response = await http.get(Uri.https(authority, unencodedPath));
    var result = chapter.Result.fromJson(jsonDecode(response.body));
    return result;
  }

  Future<search.Results> getMangaDataByMangaId(String mangaId) async {
    var unencodedPath = '/manga/$mangaId';
    var response = await http.get(Uri.http(authority, unencodedPath));
    return search.Results.fromJson(jsonDecode(response.body));
  }
}
