///////////////////////////////////////////////////////////
// The library currently only supports search, login, getting token,
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

import 'cover/Cover.dart';
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
  var headers = response.headers;
  if (headers['x-ratelimit-remaining'] == '0') {
    print('Rate Limit Exceeded.');
  } else {
    return Login.fromJson(jsonDecode(response.body));
  }
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
  var headers = response.headers;
  if (headers['x-ratelimit-remaining'] == '0') {
    print('Rate Limit Exceeded.');
  } else {
    return Search.fromJson(jsonDecode(response.body));
  }
  return Search.fromJson(jsonDecode(response.body));
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
    'manga': '$mangaId',
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
  var headers = response.headers;
  if (headers['x-ratelimit-remaining'] == '0') {
    print('Rate Limit Exceeded.');
  } else {
    return ChapterData.fromJson(jsonDecode(response.body));
  }
  return ChapterData.fromJson(jsonDecode(response.body));
}

Future<http.Response> getBaseUrlResponse(String chapterId) async {
  var unencodedPath = '/at-home/server/$chapterId';
  var response = await http.get(Uri.https(authority, unencodedPath),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

Future<BaseUrl> getBaseUrl(String chapterId) async {
  var response = await getBaseUrlResponse(chapterId);
  var headers = response.headers;
  if (headers['x-ratelimit-remaining'] == '0') {
    print('Rate Limit Exceeded.');
  } else {
    return BaseUrl.fromJson(jsonDecode(response.body));
  }
  return BaseUrl.fromJson(jsonDecode(response.body));
}

Future<String> ConstructPageUrl(String chapterId, String token,
    String chapterHash, String filename, bool dataSaver) async {
  var baseUrl = await getBaseUrl(chapterId);
  var dataMode = dataSaver ? 'data-saver' : 'data';
  return 'https://$baseUrl/$token/$dataMode/$chapterHash/$filename';
}

Future<http.Response> getCoverArtResponse([
  String? mangaID,
  String? coverID,
  int limit = 10,
  int offset = 0,
]) async {
  final mangas = mangaID != null ? '&manga[]=$mangaID' : '';
  final covers = coverID != null ? '&cover[]=$coverID' : '';
  final uri =
      'https://$authority/cover?limit=$limit&offset=$offset$mangas$covers';
  var response = await http.get(Uri.parse(uri),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

Future<Cover> getCoverArt(String mangaID) async {
  var response = await getCoverArtResponse(mangaID);
  var headers = response.headers;
  if (headers['x-ratelimit-remaining'] == '0') {
    print('Rate Limit Exceeded.');
  } else {
    return Cover.fromJson(jsonDecode(response.body));
  }
  return Cover.fromJson(jsonDecode(response.body));
}

Future<String> getCoverArtUrl(String mangaID, int? res) async {
  var reso = res ?? '';
  var data = await getCoverArt(mangaID);
  var filename = data.results[0].data.attributes.fileName;
  if (reso == 256 || reso == 512) {
    return 'https://uploads.mangadex.org/covers/$mangaID/$filename.$reso.jpg';
  } else {
    return 'https://uploads.mangadex.org/covers/$mangaID/$filename';
  }
}

class BaseUrl {
  late final String baseUrl;
  BaseUrl(this.baseUrl);
  BaseUrl.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
  }
}
