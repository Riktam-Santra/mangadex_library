///A simple library to facilitate easier access to the mangadex REST API (https://api.mangadex.org) for flutter and dart apps
///
///mangadex_library is in no way officially affiliated or recommended by mangadex.

library mangadex_library;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'mangadexServerException.dart';
import 'enum_utils.dart';

import 'models/chapter/readChapters.dart';
import 'models/common/allMangaReadingStatus.dart';
import 'models/common/content_rating.dart';
import 'models/common/language_codes.dart';
import 'models/common/mangaReadingStatus.dart';
import 'models/common/manga_status.dart';
import 'models/common/publication_demographic.dart';
import 'models/common/reading_status.dart';
import 'models/common/tag_modes.dart';
import 'models/user/user_followed_groups/user_followed_groups.dart';
import 'models/user/user_followed_users/user_followed_users.dart';
import 'models/common/resultOk.dart';
import 'models/cover/Cover.dart';
import 'models/search/Search.dart';
import 'models/chapter/ChapterData.dart';
import 'models/login/Login.dart';
import 'models/user/user_followed_manga/user_followed_manga.dart';
import 'models/user/logged_user_details/logged_user_details.dart';
import 'models/at-home/singleChapterData.dart';
import 'models/common/base_url.dart';
import 'models/common/singleMangaData.dart';

final String authority = 'api.mangadex.org';

// User login related functions

/// Returns the an http request of a JWT token for [username].
///
/// Will return null if the requests fails.
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

/// Returns the a [Login] class instance with a JWT session and refresh token for [username].
Future<Login> login(String username, String password) async {
  var response = await loginResponse(username, password);
  try {
    return Login.fromJson(jsonDecode(response.body));
  } catch (e) {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Takes in a [refresh] token and returns a *http response* of a new refresh token
Future<http.Response> getRefreshResponse(String refresh) async {
  final unencodedPath = '/auth/refresh';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode({'token': '$refresh'}));
  return response;
}

/// Takes in a refresh token and returns a [Login] class instance
/// containing the new token
Future<Login> refresh(String refreshToken) async {
  var response = await getRefreshResponse(refreshToken);
  try {
    return Login.fromJson(jsonDecode(response.body));
  } catch (e) {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Returns a http response of the user details associated with the [token]
Future<http.Response> getLoggedUserDetailsResponse(String token) async {
  final unencodedPath = '/user/me';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

/// Gets the account details of the user and returns the data
/// in a [UserDetails] class instance
Future<UserDetails> getLoggedUserDetails(String token) async {
  var response = await getLoggedUserDetailsResponse(token);
  try {
    return UserDetails.fromJson(jsonDecode(response.body));
  } catch (e) {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

// Manga search related functions

Future<http.Response> searchResponse({
  String? query,
  int? limit,
  int? offset,
  List<String>? authors,
  List<String>? artists,
  int? year,
  List<String>? includedTags,
  TagsMode? includedTagsMode,
  List<String>? excludedTags,
  TagsMode? excludedTagsMode,
  List<MangaStatus>? status,
  List<LanguageCodes>? originalLanguage,
  List<LanguageCodes>? excludedOriginalLanguages,
  List<LanguageCodes>? availableTranslatedLanguage,
  List<PublicDemographic>? publicationDemographic,
  List<String>? ids,
  List<ContentRating>? contentRating,
  String? createdAtSince,
  String? updatedAtSince,
  List<String>? includes,
  String? group,
}) async {
  var unencodedPath = '/manga';
  var Title = query != null ? '&title=$query' : '';
  var Authors = '';
  if (authors != null) {
    authors.forEach((element) {
      Authors = Authors + '&authors[]=$element';
    });
  }
  var Limit = limit != null ? '&limit=$limit' : '';
  var Offset = offset != null ? '&offset=$offset' : '';
  var Artists = '';
  if (artists != null) {
    artists.forEach((element) {
      Artists = Artists + '&artists[]=$element';
    });
  }
  var Year = year != null ? '&year=$year' : '';
  var IncludedTags = '';
  if (includedTags != null) {
    includedTags.forEach((element) {
      IncludedTags = IncludedTags + '&includedTages[]=$element';
    });
  }
  var PublicationDemographic = '';
  if (publicationDemographic != null) {
    publicationDemographic.forEach((element) {
      PublicationDemographic = PublicationDemographic +
          '&publicationDemographic[]=${EnumUtils.parsePublicDemographicFromEnum(element)}';
    });
  }
  var IncludedTagsMode = '';
  if (includedTagsMode != null) {
    IncludedTagsMode = EnumUtils.parseTagModeFromEnum(includedTagsMode);
  }
  var ExcludedTags = '';
  if (excludedTags != null) {
    excludedTags.forEach((element) {
      ExcludedTags = ExcludedTags + '&excludedTags[]=$element';
    });
  }
  var ExcludedTagsMode = '';
  if (excludedTagsMode != null) {
    ExcludedTagsMode = EnumUtils.parseTagModeFromEnum(excludedTagsMode);
  }
  var Status = '';
  if (status != null) {
    status.forEach((element) {
      Status =
          Status + '&status[]=${EnumUtils.parseMangaStatusFromEnum(element)}';
    });
  }

  var OriginalLanguage = '';
  if (originalLanguage != null) {
    originalLanguage.forEach((element) {
      OriginalLanguage = OriginalLanguage +
          '&originalLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }
  var ExcludedOriginalLanguage = '';
  if (excludedOriginalLanguages != null) {
    excludedOriginalLanguages.forEach((element) {
      ExcludedOriginalLanguage = ExcludedOriginalLanguage +
          '&excludedOriginalLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }
  var AvailableTranslatedLanguage = '';
  if (availableTranslatedLanguage != null) {
    availableTranslatedLanguage.forEach((element) {
      AvailableTranslatedLanguage = AvailableTranslatedLanguage +
          '&availableTranslatedLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }

  var Ids = '';
  if (ids != null) {
    ids.forEach((element) {
      Ids = Ids + '&ids[]=$element';
    });
  }
  var contentrating = '';
  if (contentRating != null) {
    contentRating.forEach((element) {
      contentrating = contentrating +
          '&contentRating[]=${EnumUtils.parseContentRatingFromEnum(element)}';
    });
  }
  var Includes = '';
  if (includes != null) {
    includes.forEach((element) {
      Includes = Includes + '&included[]=$element';
    });
  }
  var CreatedAtSince =
      createdAtSince != null ? '&createdAtSince=$createdAtSince' : '';
  var UpdatedAtSince =
      updatedAtSince != null ? '&updatedAtSince=$updatedAtSince' : '';
  var Group = group != null ? '&group=$group' : '';
  final url =
      'https://$authority$unencodedPath?$Title$Limit$Offset$Authors$Artists$Year$IncludedTags$IncludedTagsMode$ExcludedTags$ExcludedTagsMode$Status$OriginalLanguage$ExcludedOriginalLanguage$AvailableTranslatedLanguage$PublicationDemographic$Ids$contentrating$CreatedAtSince$UpdatedAtSince$Includes$Group';
  var response = await http.get(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

///Gets manga search results
///takes in optional parameters to filter out content
///and returns the query data in a [Search] class instance
Future<Search> search({
  String? query,
  int? limit,
  int? offset,
  List<String>? authors,
  List<String>? artists,
  int? year,
  List<String>? includedTags,
  TagsMode? includedTagsMode,
  List<String>? excludedTags,
  TagsMode? excludedTagsMode,
  List<MangaStatus>? status,
  List<LanguageCodes>? originalLanguage,
  List<LanguageCodes>? excludedOriginalLanguages,
  List<LanguageCodes>? availableTranslatedLanguage,
  List<PublicDemographic>? publicationDemographic,
  List<String>? ids,
  List<ContentRating>? contentRating,
  String? createdAtSince, // should be of format DD-MM-YYYY
  String? updatedAtSince, // should be of format DD-MM-YYYY
  List<String>? includes,
  String? group,
}) async {
  var response = await searchResponse(
    query: query,
    limit: limit,
    offset: offset,
    authors: authors,
    artists: artists,
    year: year,
    includedTags: includedTags,
    includedTagsMode: includedTagsMode,
    excludedTags: excludedTags,
    excludedTagsMode: excludedTagsMode,
    status: status,
    originalLanguage: originalLanguage,
    excludedOriginalLanguages: excludedOriginalLanguages,
    availableTranslatedLanguage: availableTranslatedLanguage,
    publicationDemographic: publicationDemographic,
    ids: ids,
    contentRating: contentRating,
    createdAtSince: createdAtSince,
    updatedAtSince: updatedAtSince,
    includes: includes,
    group: group,
  );
  try {
    var data = Search.fromJson(jsonDecode(response.body));
    return data;
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///gets details of a manga with the given [mangaId] or uuid
///Returns the manga data in a [SingleMangaData] class instance
Future<SingleMangaData> getMangaDataByMangaId(String mangaId) async {
  var unencodedPath = '/manga/$mangaId';
  var response = await http.get(Uri.http(authority, unencodedPath));
  try {
    return SingleMangaData.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

//Manga chapters related functions

///Returns the http response of a list of chapters for [mangaId]
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
          '&translatedLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }
  var OriginalLanguage = '';
  if (originalLanguage != null) {
    originalLanguage.forEach((element) {
      OriginalLanguage = OriginalLanguage +
          '&originalLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }
  var ExcludedOriginalLanguage = '';
  if (excludedOriginalLanguage != null) {
    excludedOriginalLanguage.forEach((element) {
      ExcludedOriginalLanguage = ExcludedOriginalLanguage +
          '&excludedOriginalLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }
  var Contentrating = '';
  if (contentRating != null) {
    contentRating.forEach((element) {
      Contentrating = Contentrating +
          '&contentRating[]=${EnumUtils.parseContentRatingFromEnum(element)}';
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
  print('url');
  var response = await http.get(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

///gets [limit] number of chapters for the given [mangaId] or uuid
///Returns the manga data in a [ChapterData] class instance
Future<ChapterData> getChapters(String mangaId,
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
  try {
    return ChapterData.fromJson(jsonDecode(response.body));
  } catch (e) {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///gets details of a manga with the given [chapterId] or uuid
///Returns the manga data in a [SingleChapterData] class instance
Future<SingleChapterData> getChapterDataByChapterId(String chapterId) async {
  var unencodedPath = '/at-home/server/$chapterId';
  var response = await http.get(Uri.https(authority, unencodedPath));
  try {
    return SingleChapterData.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

// Functions to get base url for a chapter ID

///Returns a http response of Base URL for [chapterId] or uuid
Future<http.Response> getBaseUrlResponse(String chapterId) async {
  var unencodedPath = '/at-home/server/$chapterId';
  var response = await http.get(Uri.https(authority, unencodedPath),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

///gets base URL of a chapter with the given [chapterId] or uuid
///Returns the Base Url data in a [BaseUrl] class instance
Future<BaseUrl> getBaseUrl(
  String chapterId,
) async {
  var response = await getBaseUrlResponse(chapterId);
  try {
    return BaseUrl.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Uses [baseUrl], [token], [chapterHash] and [filename]
/// and returns a [String] containing the full constructed address to the page
/// base url can be obtained from the [getBaseUrl] function, the token using the login() function
/// chapterHash and filename can both be obtained via [getChapterDataByChapterId]
String constructPageUrl(String baseUrl, String token, bool dataSaver,
    String chapterHash, String filename) {
  var dataMode = dataSaver ? 'data-saver' : 'data';
  return '$baseUrl/$token/$dataMode/$chapterHash/$filename';
}

/// Gets the chapter filenames just using the [chapterId] of a chapter.
/// returns a [List] of [String] containing all the file names of a chapter.
Future<List<String>> getChapterFilenames(
    String chapterId, bool isDataSaverMode) async {
  var response = await getChapterDataByChapterId(chapterId);
  if (isDataSaverMode == true) {
    return response.chapter.dataSaver;
  } else {
    return response.chapter.data;
  }
}

// Manga cover art related functions

///returns an https response with cover art details for a manga with given [mangaId] or uuid
Future<http.Response> getCoverArtResponse(
  String mangaId, [
  String? coverId,
  int limit = 10,
  int offset = 0,
]) async {
  final mangas = '&manga[]=$mangaId';
  final covers = coverId != null ? '&cover[]=$coverId' : '';
  final uri =
      'https://$authority/cover?limit=$limit&offset=$offset$mangas$covers';
  var response = await http.get(Uri.parse(uri),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

///returns an [Cover] class instance containing cover
///art details for a manga with given [mangaId] or uuid
Future<Cover> getCoverArt(String mangaId) async {
  var response = await getCoverArtResponse(mangaId);
  try {
    return Cover.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Directly get Cover art details of a manga with [mangaId]
///and return a [String] containing a url to the cover page
///
///The [res] parameter can be used to change resolution of the cover art obtained
///The [res] parameter only supports values 256 and 512
///
///The resolution remains unchanged if any other value of [res] is given.
Future<String> getCoverArtUrl(String mangaId, {int? res}) async {
  var reso = res ?? '';
  var data = await getCoverArt(mangaId);

  var filename = data.data[0].attributes.fileName;
  if (reso == 256 || reso == 512) {
    return 'https://uploads.mangadex.org/covers/$mangaId/$filename.$reso.jpg';
  } else {
    return 'https://uploads.mangadex.org/covers/$mangaId/$filename';
  }
}

// User related functions

/// Get an http response of the all the Manga user follows,
/// the [token] is the session token obtained using the login() function
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

///Simply check if the user identified by the current session [token]
///follows a manga with [mangaId] or uuid and return a http response
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

///Simply check if the user identified by the current session [token]
///follows a manga with [mangaId] or uuid and return a boolean
Future<bool> checkIfUserFollowsManga(String token, String mangaId) async {
  var response = await checkIfUserFollowsMangaResponse(token, mangaId);
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 404) {
    return false;
  } else {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Returns a [UserFollowedManga] class instance of all the Manga the user follows,
/// the [token] is the session token obtained using the login() function
Future<UserFollowedManga> getUserFollowedManga(String token,
    {int? offset, int? limit}) async {
  var response =
      await getUserFollowedMangaResponse(token, offset: offset, limit: limit);
  try {
    return UserFollowedManga.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Returns a http response of the all the Users that the user follows,
/// the [token] is the session token obtained using the[login] function
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

/// Returns a [UserFollowedUsers] class instance with details of the all the Users that the user follows,
/// the [token] is the session token obtained using the login() function
Future<UserFollowedUsers> getUserFollowedUsers(String token,
    {int? offset, int? limit}) async {
  var response =
      await getUserFollowedUsersResponse(token, offset: offset, limit: limit);
  try {
    return UserFollowedUsers.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Returns a http response of whether the user identified by the current session [token]
///follows a User with [userId] or uuid and return a http response
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

///Simply check if the user identified by the current session [token]
///follows a User with [userId] or uuid and return a bool
Future<bool> checkIfUserFollowsUser(String token, String userId) async {
  var response = await checkIfUserFollowsUserResponse(token, userId);
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 404) {
    return false;
  } else {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Returns a http response with details of the all the Groups that the user follows,
/// the [token] is the session token obtained using the login() function
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

/// Returns a [UserFollowedGroups] class instance with details of the all the Groups that the user follows,
/// the [token] is the session token obtained using the login() function
Future<UserFollowedGroups> getUserFollowedGroups(
    String token, int? offset, int? limit) async {
  var response = await getUserFollowedGroupsResponse(
    token,
    offset: offset,
    limit: limit,
  );
  try {
    return UserFollowedGroups.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Simply check if the user identified by the current session [token]
///follows a Group with [groupId] or uuid and return a http response
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

///Simply check if the user identified by the current session [token]
///follows a Group with [groupId] or uuid and return a http response
Future<bool> checkIfUserFollowsGroup(String token, String groupId) async {
  var response = await checkIfUserFollowsGroupResponse(token, groupId);
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 404) {
    return false;
  } else {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

//reading status related

///Returns an http response containing all reading statuses of all manga
///followed by the user identified by the [token]
///The [token] can be obtained using the login() function.
Future<http.Response> getAllMangaReadingStatusResponse(
    String token, String? status) async {
  var unencodedPath =
      status == null ? '/manga/status' : '/manga/status?status=$status';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

///Returns a [AllMangaReadingStatus] class instance containing all reading statuses of all manga
///followed by the user identified by the [token]
///The [token] can be obtained using the login() function.
Future<AllMangaReadingStatus> getAllUserMangaReadingStatus(String token,
    {ReadingStatus? readingStatus}) async {
  var status = '';
  if (readingStatus != null) {
    status = EnumUtils.parseStatusFromEnum(readingStatus);
  }
  var response = await getAllMangaReadingStatusResponse(token, status);
  try {
    return AllMangaReadingStatus.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Returns a [MangaReadingStatus] class instance containing the reading status
/// of a particular manga identified by [mangaId] or uuid
Future<MangaReadingStatus> getMangaReadingStatus(
    String token, String mangaId) async {
  var unencodedPath = '/manga/$mangaId/status';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  try {
    return MangaReadingStatus.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Set the reading status for a certain manga
/// If no reading status is supplied to it, the reading status is set as 'reading'
Future<Result> setMangaReadingStatus(
    String token, String mangaId, ReadingStatus? status) async {
  var statusString =
      status != null ? EnumUtils.parseStatusFromEnum(status) : 'reading';
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
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Set the reading status for a certain manga
/// If no reading status is supplied to it, the reading status is set as 'reading'
Future<Result> removeMangaReadingStatus(String token, String mangaId) async {
  var statusString = '';
  var unencodedPath = '/manga/$mangaId/status';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
    'status': '$statusString',
  });
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

//Follow or unfollow a manga

///Follow a manga identified by [mangaId] and optionally set a reading status for it.
///
///If no [readingStatus] is specified, the reading status is set to 'reading' by default
Future<Result> followManga(String token, String mangaId,
    {ReadingStatus? readingStatus}) async {
  var unencodedPath = '/manga/$mangaId/follow';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  try {
    await setMangaReadingStatus(token, mangaId, readingStatus);
  } on Exception {
    print("couldn't set reading status for manga $mangaId");
  }
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Unfollow a manga identified by [mangaId] or uuid
Future<Result> unfollowManga(String token, String mangaId) async {
  var unencodedPath = '/manga/$mangaId/follow';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.delete(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

//Manga markers related

///Returns a [ReadChapters] class instance containing details
///of all read chapters of a manga
Future<ReadChapters> getAllReadChapters(String token, String mangaId) async {
  var unencodedPath = '/manga/$mangaId/read';
  final uri = 'https://$authority$unencodedPath?';

  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  try {
    return ReadChapters.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Returns an http response with details of all read chapters in the list of given [mangaIds] or uuids,
///please note it returns a http response since the response is not always of the same schema.
Future<http.Response> getAllReadChaptersForAListOfManga(
    String token, List<String> mangaIds) async {
  var unencodedPath = '/manga/read';
  var _ids = '';
  mangaIds.forEach((element) {
    _ids = _ids + '&ids[]=$element';
  });
  final uri = 'https://$authority$unencodedPath?$_ids';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  });
  return response;
}

///Mark a chapter identified by it's [chapterId] or uuid as READ
Future<Result> markChapterRead(String token, String chapterId) async {
  var unencodedPath = '/chapter/$chapterId/read';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode({'id': '$chapterId'}));
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Mark a chapter identified by it's [chapterId] or uuid as UNREAD
Future<Result> markChapterUnread(String token, String chapterId) async {
  var unencodedPath = '/chapter/$chapterId/read';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.delete(Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode({'id': '$chapterId'}));
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Mark a multiple chapters in the list of [chapterIds] or uuids as READ
Future<Result> markMultipleChaptersRead(
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
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Mark a multiple chapters in the list of [chapterIds] or uuids as UNREAD
Future<Result> markMultipleChaptersUnread(
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
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

//Reporting success or failure on receiving an image

///Report the mangadex at-home servers if a chapter page/image is unretrieveable
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
