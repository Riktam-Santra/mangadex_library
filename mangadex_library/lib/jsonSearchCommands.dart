import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mangadex_library/models/common/singleMangaData.dart';

import '/models/common/singleChapterData.dart';

abstract class JsonUtils {
  static var authority = 'api.mangadex.org';
  static Future<List<String>> getChapterFilenames(
      String chapterId, bool isDataSaverMode) async {
    var response = await getChapterDataByChapterId(chapterId);
    if (isDataSaverMode == true) {
      return response.data.attributes.chapterDataSaver;
    } else {
      return response.data.attributes.chapterData;
    }
  }

  static Future<SingleChapterData> getChapterDataByChapterId(
      String chapterId) async {
    var unencodedPath = '/chapter/$chapterId';
    var response = await http.get(Uri.https(authority, unencodedPath));
    var result = SingleChapterData.fromJson(jsonDecode(response.body));
    return result;
  }

  static Future<SingleMangaData> getMangaDataByMangaId(String mangaId) async {
    var unencodedPath = '/manga/$mangaId';
    var response = await http.get(Uri.http(authority, unencodedPath));
    return SingleMangaData.fromJson(jsonDecode(response.body));
  }
}
