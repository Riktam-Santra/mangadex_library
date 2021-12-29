///////////////////////////////////////////////////////////
// The library currently supports all the basic features for managing the user's library, browsing manga and retrieve manga pages.
// To see an example of retrieving pages, have a look at the
// /test/mangadex_library_example.dart file.
//
// the documentation of this library will be updated in a while
// the library ISN'T complete with all the features yet
// but they will be added eventually.
///////////////////////////////////////////////////////////

library mangadex_library;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mangadex_library/models/chapter/readChapters.dart';
import 'package:mangadex_library/models/common/allMangaReadingStatus.dart';
import 'package:mangadex_library/models/common/content_rating.dart';
import 'package:mangadex_library/models/common/future_updates.dart';
import 'package:mangadex_library/models/common/language_codes.dart';
import 'package:mangadex_library/models/common/mangaReadingStatus.dart';
import 'package:mangadex_library/models/common/reading_status.dart';
import 'package:mangadex_library/models/user/user_followed_groups/user_followed_groups.dart';
import 'package:mangadex_library/models/user/user_followed_manga/manga_check.dart';
import 'package:mangadex_library/models/user/user_followed_users/user_followed_users.dart';

import '/models/common/resultOk.dart';
import '/models/cover/Cover.dart';
import '/models/search/Search.dart';
import '/models/chapter/ChapterData.dart';
import '/models/login/Login.dart';
import '/models/user/user_followed_manga/user_followed_manga.dart';
import '/models/user/logged_user_details/logged_user_details.dart';

final String authority = 'api.mangadex.org';

// User login related functions
Future<http.Response> loginResponse(String username, String password) async {
  var unencodedPath = '/auth/login';
  var response = await http.post(
    Uri.https(authority, unencodedPath),
    headers: {'content-type': 'application/json'},
    body: jsonEncode(
      {'username': '$username', 'password': '$password'},
    ),
  );
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

Future<http.Response> getLoggedUserDetailsResponse(String token) async {
  final unencodedPath = '/user/me';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

Future<UserDetails> getLoggedUserDetails(String token) async {
  var response = await getLoggedUserDetailsResponse(token);
  return UserDetails.fromJson(jsonDecode(response.body));
}

// Manga search related functions
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
    return data;
  }
}

//Manga chapters related functions
Future<http.Response> getChaptersResponse(String mangaId,
    {List<String>? ids,
    String? title,
    List<String>? groups,
    String? uploader,
    String? volume,
    String? chapter,
    List<LanguageCodes>? translatedLanguage,
    List<LanguageCodes>? originalLanguage,
    List<LanguageCodes>? excludedOriginalLanguage,
    List<ContentRating>? contentRating,
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
  var Ids = '';
  if (ids != null) {
    ids.forEach((element) {
      Ids = Ids + '&ids[]=$element';
    });
  }
  var Title = title != null ? '&title=$title' : '';
  var Groups = '';
  if (groups != null) {
    groups.forEach((element) {
      Groups = Groups + '&groups[]=$element';
    });
  }
  var Uploader = uploader != null ? '&uploader=$uploader' : '';
  var Volume = volume != null ? '&volume=$volume' : '';
  var Chapter = chapter != null ? '&chapter=$chapter' : '';

  var TranslatedLanguage = '';
  if (translatedLanguage != null) {
    translatedLanguage.forEach((element) {
      TranslatedLanguage = TranslatedLanguage +
          '&translatedLanguage[]=${parseLanguageCodeFromEnum(element)}';
    });
  }
  var OriginalLanguage = '';
  if (originalLanguage != null) {
    originalLanguage.forEach((element) {
      OriginalLanguage = OriginalLanguage +
          '&originalLanguage[]=${parseLanguageCodeFromEnum(element)}';
    });
  }
  var ExcludedOriginalLanguage = '';
  if (excludedOriginalLanguage != null) {
    excludedOriginalLanguage.forEach((element) {
      ExcludedOriginalLanguage = ExcludedOriginalLanguage +
          '&excludedOriginalLanguage[]=${parseLanguageCodeFromEnum(element)}';
    });
  }
  var Contentrating = '';
  if (contentRating != null) {
    contentRating.forEach((element) {
      Contentrating = Contentrating +
          '&contentRating[]=${parseContentRatingFromEnum(element)}';
    });
  }

  var CreatedAtSince =
      createdAtSince != null ? '&createdAtSince=$createdAtSince' : '';
  var UpdatedAtSince =
      updatedAtSince != null ? '&updatedAtSince=$updatedAtSince' : '';
  var PublishedAtSince =
      publishedAtSince != null ? '&publishedAtSince=$publishedAtSince' : '';
  var Includes = includes != null ? '&includes[]=$includes' : '';

  final url =
      'https://$authority$unencodedPath?&manga=$MangaId$Limit$Offset$Ids$Title$Groups$Uploader$Volume$Chapter$TranslatedLanguage$CreatedAtSince$UpdatedAtSince$PublishedAtSince$Includes';
  print('Url: $url');
  var response = await http.get(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

Future<ChapterData?> getChapters(String mangaId,
    {List<String>? ids,
    String? title,
    List<String>? groups,
    String? uploader,
    String? volume,
    String? chapter,
    List<LanguageCodes>? translatedLanguage,
    List<LanguageCodes>? originalLanguage,
    List<LanguageCodes>? excludedOriginalLanguage,
    List<ContentRating>? contentRating,
    String? createdAtSince,
    String? updatedAtSince,
    String? publishedAtSince,
    String? includes,
    int? limit,
    int? offset}) async {
  var _chapterOffset = offset ?? 0;
  var _ChapterLimit = limit ?? 10;
  var response = await getChaptersResponse(
    mangaId,
    offset: _chapterOffset,
    limit: _ChapterLimit,
    ids: ids,
    title: title,
    groups: groups,
    uploader: uploader,
    volume: volume,
    chapter: chapter,
    translatedLanguage: translatedLanguage,
    originalLanguage: originalLanguage,
    excludedOriginalLanguage: excludedOriginalLanguage,
    contentRating: contentRating,
    createdAtSince: createdAtSince,
    updatedAtSince: updatedAtSince,
    publishedAtSince: publishedAtSince,
  );
  var headers = response.headers;
  if (headers['x-ratelimit-remaining'] == '0') {
    print('Rate Limit Exceeded.');
  } else {
    try {
      var data = ChapterData.fromJson(jsonDecode(response.body));
      if (data.data.isNotEmpty) {
        return data;
      } else {
        print(
            'chapter with the manga ID $mangaId not found. Make sure the manga id isn\'t an empty String.');
      }
    } catch (e) {
      print(response.body);
    }
  }
}

// Functions to get base url for a chapter ID
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

// A function to create URl to a manga page
Future<String> constructPageUrl(String chapterId, String token,
    String chapterHash, String filename, bool dataSaver) async {
  var baseUrl = await getBaseUrl(chapterId);
  var dataMode = dataSaver ? 'data-saver' : 'data';
  return '${baseUrl!.baseUrl}/$token/$dataMode/$chapterHash/$filename';
}

// Manga cover art related functions
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

  var filename = data!.data[0].attributes.fileName;
  if (reso == 256 || reso == 512) {
    return 'https://uploads.mangadex.org/covers/$mangaID/$filename.$reso.jpg';
  } else {
    return 'https://uploads.mangadex.org/covers/$mangaID/$filename';
  }
}

// User related functions
Future<http.Response> getUserFollowedMangaResponse(String token,
    {int? offset, int? limit}) async {
  final _offset = '&offset=${offset ?? 0}';
  final _limit = '&limit=${limit ?? 10}';
  final unencodedPath = '/user/follows/manga?$_offset$_limit';
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

Future<bool> checkIfUserFollowsManga(String token, String mangaId) async {
  var response = await checkIfUserFollowsMangaResponse(token, mangaId);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<UserFollowedManga> getUserFollowedManga(String token,
    {int? offset, int? limit}) async {
  var response =
      await getUserFollowedMangaResponse(token, offset: offset, limit: limit);
  return UserFollowedManga.fromJson(jsonDecode(response.body));
}

Future<http.Response> getUserFollowedUsersResponse(String token,
    {int? offset, int? limit}) async {
  final _offset = '&offset=${offset ?? 0}';
  final _limit = '&limit=${limit ?? 10}';
  final unencodedPath = '/user/follows/user?$_offset$_limit';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

Future<UserFollowedUsers> getUserFollowedUsers(String token,
    {int? offset, int? limit}) async {
  var response =
      await getUserFollowedUsersResponse(token, offset: offset, limit: limit);
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

Future<bool> checkIfUserFollowsUser(String token, String userId) async {
  var response = await checkIfUserFollowsUserResponse(token, userId);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<http.Response> getUserFollowedGroupsResponse(String token,
    {int? offset, int? limit}) async {
  final _offset = '&offset=${offset ?? 0}';
  final _limit = '&limit=${limit ?? 10}';
  final unencodedPath = '/user/follows/group?$_offset$_limit';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

Future<UserFollowedGroups> getUserFollowedGroups(
    String token, int? offset, int? limit) async {
  var response = await getUserFollowedGroupsResponse(
    token,
    offset: offset,
    limit: limit,
  );
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

Future<bool> checkIfUserFollowsGroup(String token, String groupId) async {
  var response = await checkIfUserFollowsGroupResponse(token, groupId);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

//reading status related

Future<http.Response> getAllMangaReadingStatusResponse(
    String token, String status) async {
  var unencodedPath =
      status == '' ? '/manga/status' : '/manga/status?status=$status';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

Future<AllMangaReadingStatus> getAllUserMangaReadingStatus(String token,
    {ReadingStatus? readingStatus}) async {
  var status = '';
  if (readingStatus != null) {
    status = parseStatusFromEnum(readingStatus);
  }
  var data = await getAllMangaReadingStatusResponse(token, status);
  return AllMangaReadingStatus.fromJson(jsonDecode(data.body));
}

Future<MangaReadingStatus> getMangaReadingStatus(
    String token, String mangaId) async {
  var unencodedPath = '/manga/$mangaId/status';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return MangaReadingStatus.fromJson(jsonDecode(response.body));
}

Future<ResultOk> setMangaReadingStatus(
    String token, String mangaId, ReadingStatus? status) async {
  var statusString = status != null ? parseStatusFromEnum(status) : 'reading';
  var unencodedPath = '/manga/$mangaId/status';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode({
        'status': '$statusString',
      }));
  print(response.body);
  return ResultOk.fromJson(jsonDecode(response.body));
}

Future<MangaCheck?> removeMangaReadingStatus(
    String token, String mangaId) async {
  var statusString = '';
  var unencodedPath = '/manga/$mangaId/status';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
    'status': '$statusString',
  });
  return MangaCheck.fromJson(jsonDecode(response.body));
}

//Follow or unfollow a manga
Future<MangaCheck> followManga(String token, String mangaId,
    {ReadingStatus? status}) async {
  var unencodedPath = '/manga/$mangaId/follow';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });

  try {
    //set manga reading status by default
    await setMangaReadingStatus(token, mangaId, status);
    print(
        'set reading status as \'${status != null ? status.toString() : 'reading'}\' for manga $mangaId');
  } catch (e) {
    print("couldn't set reading status for manga $mangaId");
  }
  return MangaCheck.fromJson(jsonDecode(response.body));
}

Future<MangaCheck> unfollowManga(String token, String mangaId) async {
  var unencodedPath = '/manga/$mangaId/follow';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.delete(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return MangaCheck.fromJson(jsonDecode(response.body));
}

//Manga markers related

Future<ReadChapters?> getAllReadChapters(String token, String mangaId) async {
  // get all read chapters for the given mangaId,
  var unencodedPath = '/manga/$mangaId/read';
  final uri = 'https://$authority$unencodedPath?';

  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  try {
    return ReadChapters.fromJson(jsonDecode(response.body));
  } catch (e) {
    print(response);
    print(e.toString());
  }
}

Future<http.Response> getAllReadChaptersForAListOfManga(
    String token, List<String> mangaIds) async {
  // get all read chapters in the given mangaIds,
  // please note it returns an http response since the response is not always of the same schema.
  var unencodedPath = '/manga/read';
  var _ids = '';
  mangaIds.forEach((element) {
    _ids = _ids + '&ids[]=$element';
  });
  print(_ids);
  final uri = 'https://$authority$unencodedPath?$_ids';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

Future<ResultOk> markChapterRead(String token, String chapterId) async {
  var unencodedPath = '/chapter/$chapterId/read';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode({'id': '$chapterId'}));
  print(response.body);
  return ResultOk.fromJson(jsonDecode(response.body));
}

Future<ResultOk> markChapterUnread(String token, String chapterId) async {
  var unencodedPath = '/chapter/$chapterId/read';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.delete(Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode({'id': '$chapterId'}));
  return ResultOk.fromJson(jsonDecode(response.body));
}

Future<ResultOk> markMultipleChaptersRead(
    String token, String mangaId, List<String> chapterIds) async {
  var idList = [];
  chapterIds.forEach((element) {
    idList.add(element);
  });
  var payload = {
    'chapterIdsRead': chapterIds.toString(),
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
  var unencodedPath = '/manga/$mangaId/read';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri), headers: payload);
  return ResultOk.fromJson(jsonDecode(response.body));
}

Future<ResultOk> markMultipleChaptersUnread(
    String token, String mangaId, List<String> chapterIds) async {
  var idList = [];
  chapterIds.forEach((element) {
    idList.add(element);
  });
  var payload = {
    'chapterIdsRead': chapterIds.toString(),
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
  var unencodedPath = '/manga/$mangaId/unread';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri), headers: payload);
  return ResultOk.fromJson(jsonDecode(response.body));
}

String parseStatusFromEnum(ReadingStatus status) {
  switch (status) {
    case ReadingStatus.completed:
      return 'completed';
    case ReadingStatus.dropped:
      return 'dropped';
    case ReadingStatus.on_hold:
      return 'on_hold';
    case ReadingStatus.plan_to_read:
      return 'plan_to_read';
    case ReadingStatus.re_reading:
      return 're_reading';
    case ReadingStatus.reading:
      return 'reading';
  }
}

String parseLanguageCodeFromEnum(LanguageCodes code) {
  switch (code) {
    case LanguageCodes.en:
      return 'en';
    case LanguageCodes.es:
      return 'es';
    case LanguageCodes.es_la:
      return 'es-la';
    case LanguageCodes.ja_ro:
      return 'ja-ro';
    case LanguageCodes.ko_ro:
      return 'ko-ro';
    case LanguageCodes.pt_br:
      return 'pt-br';
    case LanguageCodes.zh:
      return 'zh';
    case LanguageCodes.zh_hk:
      return 'zh-hk';
    case LanguageCodes.zh_ro:
      return 'zh-ro';
  }
}

String parseContentRatingFromEnum(ContentRating rating) {
  switch (rating) {
    case ContentRating.erotica:
      return 'erotica';
    case ContentRating.pornographic:
      return 'pornographic';
    case ContentRating.safe:
      return 'safe';
    case ContentRating.suggestive:
      return 'suggestive';
  }
}

String parseFutureUpdatesFromEnum(FutureUpdates update) {
  switch (update) {
    case FutureUpdates.enable:
      return '1';
    case FutureUpdates.disable:
      return '2';
  }
}

// Base url class to parse base url
class BaseUrl {
  late final String baseUrl;
  BaseUrl(this.baseUrl);
  BaseUrl.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
  }
}

//Reporting success or failure on receiving an image
Future<void> reportImageStatus(
    String pageUrl, bool success, bool cached, int bytes, int duration) async {
  final uri = 'https://api.mangadex.network/report';
  await http.post(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    'url': pageUrl,
    'success': '$success',
    'cached': '$cached',
    'bytes': '$bytes',
    'duration': '$duration',
  });
}
