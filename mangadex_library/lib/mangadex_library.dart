///////////////////////////////////////////////////////////
// The library currently only supports search, login, getting token,
// getting chapters data using the manga ID, and finally using the
// login token to get base url used to retireve pages.
// To see an example of retrieving pages, have a look at the
// mangadex_library_test.dart file.
//
// the documentation of this library will be updated in a while
// there aren't much features yet
// but they will be added eventually.
///////////////////////////////////////////////////////////

library mangadex_library;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mangadex_library/user/logged_user_details/logged_user_details.dart';
import 'package:mangadex_library/user/user_followed_groups/user_followed_groups.dart';
import 'package:mangadex_library/user/user_followed_users/user_followed_users.dart';

import 'cover/Cover.dart';
import 'search/Search.dart';
import 'chapter/ChapterData.dart';
import 'login/Login.dart';
import 'user/user_followed_manga/user_followed_manga.dart';

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
  print(url);
  return response;
}

Future<ChapterData?> getChapters(String mangaId,
    {int? offset, int? limit}) async {
  var _chapterOffset = offset ?? 0;
  var _ChapterLimit = limit ?? 10;
  var response = await getChaptersResponse(mangaId,
      offset: _chapterOffset, limit: _ChapterLimit);
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
  String _chapterId,
) async {
  var response = await getBaseUrlResponse(_chapterId);
  var headers = response.headers;
  if (headers['x-ratelimit-remaining'] == '0') {
    print('Rate Limit Exceeded.');
  } else {
    if (_chapterId == '') {
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
  final unencodedPath = '/auth/refresh';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode({'token': '$refresh'}));
  return response;
}

Future<Login> refresh(String refreshToken) async {
  var response = await getRefreshResponse(refreshToken);
  return Login.fromJson(jsonDecode(response.body));
}

Future<http.Response> getUserFollowedMangaResponse(String token) async {
  final unencodedPath = '/user/follows/manga';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

Future<http.Response> checkIfUserFollowsMangaResponse(
    String token, String mangaId) async {
  final unencodedPath = '/user/follows/manga/$mangaId';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

Future<UserFollowedUsers> checkIfUserFollowsManga(
    String token, String mangaId) async {
  var response = await checkIfUserFollowsUserResponse(token, mangaId);
  return UserFollowedUsers.fromJson(jsonDecode(response.body));
}

Future<UserFollowedManga> getUserFollowedManga(String token) async {
  var response = await getUserFollowedMangaResponse(token);
  return UserFollowedManga.fromJson(jsonDecode(response.body));
}

Future<http.Response> getUserFollowedUsersResponse(String token) async {
  final unencodedPath = '/user/follows/user';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

Future<UserFollowedUsers> getUserFollowedUsers(String token) async {
  var response = await getUserFollowedMangaResponse(token);
  return UserFollowedUsers.fromJson(jsonDecode(response.body));
}

Future<http.Response> checkIfUserFollowsUserResponse(
    String token, String userId) async {
  final unencodedPath = '/user/follows/user/$userId';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

Future<UserFollowedUsers> checkIfUserFollowsUser(
    String token, String userId) async {
  var response = await checkIfUserFollowsUserResponse(token, userId);
  return UserFollowedUsers.fromJson(jsonDecode(response.body));
}

Future<http.Response> getUserFollowedGroupsResponse(String token) async {
  final unencodedPath = '/user/follows/group';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

Future<UserFollowedGroups> getUserFollowedGroups(String token) async {
  var response = await getUserFollowedMangaResponse(token);
  return UserFollowedGroups.fromJson(jsonDecode(response.body));
}

Future<http.Response> checkIfUserFollowsGroupResponse(
    String token, String groupId) async {
  final unencodedPath = '/user/follows/group/$groupId';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

Future<UserFollowedUsers> checkIfUserFollowsGroup(
    String token, String groupId) async {
  var response = await checkIfUserFollowsUserResponse(token, groupId);
  return UserFollowedUsers.fromJson(jsonDecode(response.body));
}

Future<http.Response> getLoggedUserDetailsResponse(String token) async {
  final unencodedPath = '/user/follows/user/me';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

Future<LoggedUserDetails> getLoggedUserDetails(
    String token, String groupId) async {
  var response = await getLoggedUserDetailsResponse(token);
  return LoggedUserDetails.fromJson(jsonDecode(response.body));
}

class BaseUrl {
  late final String baseUrl;
  BaseUrl(this.baseUrl);
  BaseUrl.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
  }
}
