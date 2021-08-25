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

Future<Login?> login(String username, String password) async {
  var response = await loginResponse(username, password);
  var headers = response.headers;
  if (headers['x-ratelimit-remaining'] == '0') {
    print('Rate Limit Exceeded.');
  } else {
    return Login.fromJson(jsonDecode(response.body));
  }
}

Future<http.Response> searchResponse(String query,
    {String? includedTagsMode,
    String? artists,
    String? publicationDemographic,
    String? includedTags,
    String? ids,
    String? excludedTags,
    String? excludedTagsMode,
    String? status,
    String? contentRating,
    String? limit,
    String? originalLanguage,
    String? authors}) async {
  var unencodedPath = '/manga';
  var Title = '&title=$query';
  var IncludedTagsMode = includedTagsMode != null
      ? '&includedTagsMode=$includedTagsMode'
      : '&includedTagsMode=AND';
  var Artists = artists != null ? '&artists[]=$artists' : '';
  var PublicationDemographic = publicationDemographic != null
      ? '&publicationDemographic[]=$publicationDemographic'
      : '';
  var IncludedTags =
      includedTags != null ? '&includedTags[]=$includedTags' : '';
  var Ids = ids != null ? '&ids[]=$ids' : '';
  var ExcludedTags =
      excludedTags != null ? '&excludedTags[]=$excludedTags' : '';
  var ExcludedTagsMode = excludedTagsMode != null
      ? '&excludedTagsMode=$excludedTagsMode'
      : '&excludedTagsMode=OR';
  var Status = status != null ? '&status[]=$status' : '';
  var ContentRating =
      contentRating != null ? '&contentRating[]=$contentRating' : '';
  var Limit = limit != null ? '&limit=$limit' : '&limit=10';
  var OriginalLanguage =
      originalLanguage != null ? '&originalLanguage[]=$originalLanguage' : '';
  var Authors = authors != null ? '&authors[]=$authors' : '';
  final url =
      'https://$authority$unencodedPath?$Title$IncludedTagsMode$Artists$PublicationDemographic$IncludedTags$Ids$ExcludedTags$ExcludedTagsMode$Status$ContentRating$Limit$OriginalLanguage$Authors';
  var response = await http.get(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

Future<Search?> search(String query) async {
  var response = await searchResponse(query);
  var headers = response.headers;
  if (headers['x-ratelimit-remaining'] == '0') {
    print('Rate Limit Exceeded.');
  } else {
    var data = Search.fromJson(jsonDecode(response.body));
    if (data.results.isNotEmpty) {
      return data;
    }
    if (data.results.isEmpty) {
      print('Search empty!');
      print('Response body: \n' + response.body);
    }
  }
}

Future<http.Response> getChaptersResponse(String mangaId,
    {String? ids,
    String? title,
    String? groups,
    String? uploader,
    String? volume,
    String? chapter,
    String? translatedLanguage,
    String? createdAtSince,
    String? updatedAtSince,
    String? publishedAtSince,
    String? includes,
    int? limit,
    int? offset}) async {
  var unencodedPath = '/chapter';
  var MangaId = mangaId;
  var Limit = limit != null ? '&limit=$limit' : '&limit=10';
  var Offset = offset != null ? '&offset=$offset' : '&offset=0';
  var Ids = ids != null ? '&ids[]=$ids' : '';
  var Title = title != null ? '&title=$title' : '';
  var Groups = groups != null ? '&groups[]=$groups' : '';
  var Uploader = uploader != null ? '&uploader=$uploader' : '';
  var Volume = volume != null ? '&volume=$volume' : '';
  var Chapter = chapter != null ? '&chapter=$chapter' : '';
  var TranslatedLanguage = translatedLanguage != null
      ? '&translatedLanguage[]=$translatedLanguage'
      : '';
  var CreatedAtSince =
      createdAtSince != null ? '&createdAtSince=$createdAtSince' : '';
  var UpdatedAtSince =
      updatedAtSince != null ? '&updatedAtSince=$updatedAtSince' : '';
  var PublishedAtSince =
      publishedAtSince != null ? '&publishedAtSince=$publishedAtSince' : '';
  var Includes = includes != null ? '&includes[]=$includes' : '';

  final url =
      'https://$authority$unencodedPath?&manga=$MangaId$Limit$Offset$Ids$Title$Groups$Uploader$Volume$Chapter$TranslatedLanguage$CreatedAtSince$UpdatedAtSince$PublishedAtSince$Includes';

  var response = await http.get(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});

  return response;
}

Future<ChapterData?> getChapters(String mangaId) async {
  var response = await getChaptersResponse(mangaId);
  var headers = response.headers;
  if (headers['x-ratelimit-remaining'] == '0') {
    print('Rate Limit Exceeded.');
  } else {
    var data = ChapterData.fromJson(jsonDecode(response.body));
    if (data.result.isNotEmpty) {
      return data;
    } else {
      print(
          'chapter with the manga ID $mangaId not found. Make sure the manga id isn\'t an empty String.');
    }
  }
}

Future<http.Response> getBaseUrlResponse(String chapterId) async {
  var unencodedPath = '/at-home/server/$chapterId';
  var response = await http.get(Uri.https(authority, unencodedPath),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

Future<BaseUrl?> getBaseUrl(
  String chapterId,
) async {
  var response = await getBaseUrlResponse(chapterId);
  var headers = response.headers;
  if (headers['x-ratelimit-remaining'] == '0') {
    print('Rate Limit Exceeded.');
  } else {
    if (chapterId == '') {
      print('Chapter ID is an empty String!');
    } else {
      return BaseUrl.fromJson(jsonDecode(response.body));
    }
  }
}

Future<String> ConstructPageUrl(String chapterId, String token,
    String chapterHash, String filename, bool dataSaver) async {
  var baseUrl = await getBaseUrl(chapterId);
  var dataMode = dataSaver ? 'data-saver' : 'data';
  return 'https://$baseUrl/$token/$dataMode/$chapterHash/$filename';
}

Future<http.Response> getCoverArtResponse(
  String mangaID, [
  String? coverID,
  int limit = 10,
  int offset = 0,
]) async {
  final mangas = '&manga[]=$mangaID';
  final covers = coverID != null ? '&cover[]=$coverID' : '';
  final uri =
      'https://$authority/cover?limit=$limit&offset=$offset$mangas$covers';
  var response = await http.get(Uri.parse(uri),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

Future<Cover?> getCoverArt(String mangaID) async {
  var response = await getCoverArtResponse(mangaID);
  var headers = response.headers;
  if (headers['x-ratelimit-remaining'] == '0') {
    print('Rate Limit Exceeded.');
  } else {
    return Cover.fromJson(jsonDecode(response.body));
  }
}

Future<String> getCoverArtUrl(String mangaID, {int? res}) async {
  var reso = res ?? '';
  var data = await getCoverArt(mangaID);

  var filename = data!.results[0].data.attributes.fileName;
  if (reso == 256 || reso == 512) {
    return 'https://uploads.mangadex.org/covers/$mangaID/$filename.$reso.jpg';
  } else {
    return 'https://uploads.mangadex.org/covers/$mangaID/$filename';
  }
}

Future<http.Response> getRefreshResponse(String refresh) async {
  final uri = 'https://$authority/auth/refresh';
  var response = await http.post(Uri.parse(uri),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: {'token': '$refresh'});
  return response;
}

Future<Login> refresh(String refreshToken) async {
  var response = await getRefreshResponse(refreshToken);
  return Login.fromJson(jsonDecode(response.body));
}

class BaseUrl {
  late final String baseUrl;
  BaseUrl(this.baseUrl);
  BaseUrl.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
  }
}
