///////////////////////////////////////////////////////////
// The library currently only supports search, login, getting toke,
// getting chapters data using the manga ID, and finally using the
// login token to get base url used to retireve pages.
// To see an example of retrieving pages, have a look at the
// mangadex_library_test.dart file.
//
// the documentation of this library will be updated in a while
// there aren't much features yet (not even rate limiting)
// but they will be added eventually.
///////////////////////////////////////////////////////////

library mangadex_library;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'search/Search.dart';
import 'chapter/ChapterData.dart';
import 'login/Login.dart';

final String authority = 'api.mangadex.org';

Future<http.Response> loginResponse(String username, String password) async {
  var unencodedPath = '/auth/login';
  var response = await http.post(Uri.https(authority, unencodedPath),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({'username': '$username', 'password': '$password'}));
  return response;
}

Future<Login> login(String username, String password) async {
  var response = await loginResponse(username, password);
  return Login.fromJson(jsonDecode(response.body));
}

Future<http.Response> searchResponse(String query) async {
  var unencodedPath = '/manga';
  final queryParameters = {
    'title': '$query',
    'includedTagsMode': 'AND',
    'artists': [],
    'publicationDemographic': [],
    'includedTags': [],
    'ids': [],
    'excludedTags': [],
    'excludedTagsMode': 'OR',
    'status': [],
    'contentRating': [],
    'limit': '10',
    'originalLanguage': [],
    'authors': []
  };
  var response = await http.get(
      Uri.https(authority, unencodedPath, queryParameters),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

Future<Search> search(String query) async {
  var response = await searchResponse(query);
  var search = Search.fromJson(jsonDecode(response.body));
  return search;
}

Future<http.Response> getChaptersResponse(String mangaId) async {
  var unencodedPath = '/chapter';
  final queryParameters = {
    'limit': '10',
    'offset': '0',
    //'ids': [],
    //'title': '',
    //'groups': [],
    //'uploader': null,
    'manga': '0296dc0b-7635-4154-927a-33c2244c4503',
    //'volume': [],
    //'chapter': [],
    //'translatedLanguage': [],
    //'createdAtSince': null,
    //'updatedAtSince': null,
    //'publishAtSince': null,
    //'includes': []
  };
  var response = await http.get(
      Uri.https(authority, unencodedPath, queryParameters),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});

  return response;
}

Future<ChapterData> getChapters(String mangaId) async {
  var response = await getChaptersResponse(mangaId);
  var chapterData = ChapterData.fromJson(jsonDecode(response.body));
  return chapterData;
}

Future<http.Response> getServer(String chapterId) async {
  var unencodedPath = '/at-home/server/$chapterId';
  var response = await http.get(Uri.https(authority, unencodedPath),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

Future<BaseUrl> getBaseUrl(String chapterId) async {
  var response = await getServer(chapterId);
  return BaseUrl.fromJson(jsonDecode(response.body));
}

Future<String> ConstructUrl(String chapterId, String token, String chapterHash,
    String filename, bool dataSaver) async {
  var baseUrl = await getBaseUrl(chapterId);
  var dataMode = dataSaver ? 'data-saver' : 'data';
  return 'https://$baseUrl/$token/$dataMode/$chapterHash/$filename';
}

String ConstructThumbUrl(String mangaId, String coverFilename, {int? Size}) {
  if (Size != null) {
    return 'https://uploads.mangadex.org/covers/$mangaId/$coverFilename.$Size.png';
  } else {
    return 'https://uploads.mangadex.org/covers/$mangaId/$coverFilename';
  }
}

class BaseUrl {
  late final String baseUrl;
  BaseUrl(this.baseUrl);
  BaseUrl.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
  }
}
