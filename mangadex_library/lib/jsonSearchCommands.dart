import 'dart:convert';

import 'package:mangadex_library/models/chapter/ChapterData.dart' as chapter;
import 'package:http/http.dart' as http;
import 'package:mangadex_library/models/search/Search.dart' as search;
import 'package:mangadex_library/models/user/user_followed_users/user_followed_users.dart';

class JsonSearch {
  var authority = 'api.mangadex.org';
  Future<List<String>> getChapterFilenames(
      String chapterId, bool isDataSaverMode) async {
    var response = await getChapterDataByChapterId(chapterId);
    if (isDataSaverMode == true) {
      return response.attributes.chapterDataSaver;
    } else {
      return response.attributes.chapterData;
    }
  }

  Future<chapter.Data> getChapterDataByChapterId(String chapterId) async {
    var unencodedPath = '/chapter/$chapterId';
    var response = await http.get(Uri.https(authority, unencodedPath));
    var result = chapter.Data.fromJson(jsonDecode(response.body));
    return result;
  }

  Future<Data> getMangaDataByMangaId(String mangaId) async {
    var unencodedPath = '/manga/$mangaId';
    var response = await http.get(Uri.http(authority, unencodedPath));
    return Data.fromJson(jsonDecode(response.body));
  }
}
