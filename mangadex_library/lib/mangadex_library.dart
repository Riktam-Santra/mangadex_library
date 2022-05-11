///A simple library to facilitate easier access to the mangadex REST API (https://api.mangadex.org) for flutter and dart apps
///
///mangadex_library is in no way officially affiliated or recommended by mangadex.

library mangadex_library;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mangadex_library/models/author/author_info.dart';
import 'package:mangadex_library/models/author/author_search_results.dart';
import 'package:mangadex_library/models/common/visibility.dart';
import 'package:mangadex_library/models/custom_lists/custom_list_confirmation.dart';
import 'package:mangadex_library/models/login/token_check.dart';
import 'package:mangadex_library/models/user/user_feed/user_feed.dart';

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

/// Returns the a http request of a JWT token for [username].
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

/// Takes in a [refreshToken] token and returns a *http response* of a new refresh token
Future<http.Response> getRefreshResponse(String refreshToken) async {
  final unencodedPath = '/auth/refresh';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode({'token': '$refreshToken'}));
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

/// Returns an http response with data on whether the [sessionToken] is authenticated and the
/// user's permissions.
Future<http.Response> checkTokenResponse(String sessionToken) async {
  final unencodedPath = '/auth/check';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

/// Returns an [AuthenticationCheck] class instance with data on whether the [sessionToken] is authenticated and the
/// user's permissions.
Future<AuthenticationCheck> checkToken(String sessionToken) async {
  var response = await checkTokenResponse(sessionToken);
  try {
    return AuthenticationCheck.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Returns a http response of the user details associated with the [sessionToken]
Future<http.Response> getLoggedUserDetailsResponse(String sessionToken) async {
  final unencodedPath = '/user/me';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

/// Gets the account details of the user and returns the data
/// in a [UserDetails] class instance
Future<UserDetails> getLoggedUserDetails(String sessionToken) async {
  var response = await getLoggedUserDetailsResponse(sessionToken);
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
  Map<String, dynamic>? order,
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
  var Order = order != null
      ? '&order[${order.entries.first}]=${order[order.entries.first]}'
      : '&order[recentlyUpdated]=desc';
  final url =
      'https://$authority$unencodedPath?$Title$Limit$Offset$Authors$Artists$Year$IncludedTags$IncludedTagsMode$ExcludedTags$ExcludedTagsMode$Status$OriginalLanguage$ExcludedOriginalLanguage$AvailableTranslatedLanguage$PublicationDemographic$Ids$contentrating$CreatedAtSince$UpdatedAtSince$Includes$Group$Order';
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
  Map<String, dynamic>? order,
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

/// Uses [baseUrl], [sessionToken], [chapterHash] and [filename]
/// and returns a [String] containing the full constructed address to the page
/// base url can be obtained from the [getBaseUrl] function, the token using the login() function
/// chapterHash and filename can both be obtained via [getChapterDataByChapterId]
String constructPageUrl(String baseUrl, String sessionToken, bool dataSaver,
    String chapterHash, String filename) {
  var dataMode = dataSaver ? 'data-saver' : 'data';
  return '$baseUrl/$sessionToken/$dataMode/$chapterHash/$filename';
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

///returns a https response with cover art details for a manga with given [mangaId] or uuid
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

/// Get a http response of the all the Manga user follows,
/// the [sessionToken] is the session token obtained using the login() function
Future<http.Response> getUserFollowedMangaResponse(String sessionToken,
    {int? offset, int? limit}) async {
  final _offset = '&offset=${offset ?? 0}';
  final _limit = '&limit=${limit ?? 10}';
  final unencodedPath = '/user/follows/manga?$_offset$_limit';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

///Simply check if the user identified by the current session [sessionToken]
///follows a manga with [mangaId] or uuid and return a http response
Future<http.Response> checkIfUserFollowsMangaResponse(
    String sessionToken, String mangaId) async {
  final unencodedPath = '/user/follows/manga/$mangaId';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

///Simply check if the user identified by the current session [sessionToken]
///follows a manga with [mangaId] or uuid and return a boolean
Future<bool> checkIfUserFollowsManga(
    String sessionToken, String mangaId) async {
  var response = await checkIfUserFollowsMangaResponse(sessionToken, mangaId);
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 404) {
    return false;
  } else {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Returns a [UserFollowedManga] class instance of all the Manga the user follows,
/// the [sessionToken] is the session token obtained using the login() function
Future<UserFollowedManga> getUserFollowedManga(String sessionToken,
    {int? offset, int? limit}) async {
  var response = await getUserFollowedMangaResponse(sessionToken,
      offset: offset, limit: limit);
  try {
    return UserFollowedManga.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Returns a http response of the all the Users that the user follows,
/// the [sessionToken] is the session token obtained using the[login] function
Future<http.Response> getUserFollowedUsersResponse(String sessionToken,
    {int? offset, int? limit}) async {
  final _offset = '&offset=${offset ?? 0}';
  final _limit = '&limit=${limit ?? 10}';
  final unencodedPath = '/user/follows/user?$_offset$_limit';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

/// Returns a [UserFollowedUsers] class instance with details of the all the Users that the user follows,
/// the [sessionToken] is the session token obtained using the login() function
Future<UserFollowedUsers> getUserFollowedUsers(String sessionToken,
    {int? offset, int? limit}) async {
  var response = await getUserFollowedUsersResponse(sessionToken,
      offset: offset, limit: limit);
  try {
    return UserFollowedUsers.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Returns a http response of whether the user identified by the current session [sessionToken]
///follows a User with [userId] or uuid and return a http response
Future<http.Response> checkIfUserFollowsUserResponse(
    String sessionToken, String userId) async {
  final unencodedPath = '/user/follows/user/$userId';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

///Simply check if the user identified by the current session [sessionToken]
///follows a User with [userId] or uuid and return a bool
Future<bool> checkIfUserFollowsUser(String sessionToken, String userId) async {
  var response = await checkIfUserFollowsUserResponse(sessionToken, userId);
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 404) {
    return false;
  } else {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Returns a http response with details of the all the Groups that the user follows,
/// the [sessionToken] is the session token obtained using the login() function
Future<http.Response> getUserFollowedGroupsResponse(String sessionToken,
    {int? offset, int? limit}) async {
  final _offset = '&offset=${offset ?? 0}';
  final _limit = '&limit=${limit ?? 10}';
  final unencodedPath = '/user/follows/group?$_offset$_limit';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

/// Returns a [UserFollowedGroups] class instance with details of the all the Groups that the user follows,
/// the [sessionToken] is the session token obtained using the login() function
Future<UserFollowedGroups> getUserFollowedGroups(
    String sessionToken, int? offset, int? limit) async {
  var response = await getUserFollowedGroupsResponse(
    sessionToken,
    offset: offset,
    limit: limit,
  );
  try {
    return UserFollowedGroups.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Simply check if the user identified by the current session [sessionToken]
///follows a Group with [groupId] or uuid and return a http response
Future<http.Response> checkIfUserFollowsGroupResponse(
    String sessionToken, String groupId) async {
  final unencodedPath = '/user/follows/group/$groupId';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

///Simply check if the user identified by the current session [sessionToken]
///follows a Group with [groupId] or uuid and return a http response
Future<bool> checkIfUserFollowsGroup(
    String sessionToken, String groupId) async {
  var response = await checkIfUserFollowsGroupResponse(sessionToken, groupId);
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 404) {
    return false;
  } else {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Returns a http response containing the user feed for the user
///identified by the [sessionToken].
Future<http.Response> getUserFeedResponse(String sessionToken) async {
  final unencodedPath = '/user/follows/manga/feed';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

/// Gets the current User Feed for the user identified
/// by [sessionToken] and returns the data in a
/// [UserFeed] class instance.
Future<UserFeed> getUserFeed(String sessionToken) async {
  var response = await getUserFeedResponse(sessionToken);
  try {
    return UserFeed.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Gets the [limit] number of custom lists from [offset]
/// in the list of Custom Lists of the user identified
/// by the [sessionToken] and returns a http response
/// containing the data.
Future<http.Response> getLoggedInUserCustomListsResponse(
    String sessionToken, int? limit, int? offset) async {
  var _limit = limit == null ? '' : '?limit=$limit';
  var _offset = offset == null ? '' : '&offset=$offset';
  final unencodedPath = '/user/list';
  final uri = 'https://$authority$unencodedPath$_limit$_offset';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

/// Gets the [limit] number of custom lists from [offset]
/// in the list of Custom Lists of the user identified
/// by the [sessionToken] and returns a [SingleCustomListResponse]
/// class instance containing all the lists and their data.
Future<SingleCustomListResponse> getLoggedInUserCustomLists(
    String sessionToken, int? limit, int? offset) async {
  var response =
      await getLoggedInUserCustomListsResponse(sessionToken, limit, offset);
  try {
    return SingleCustomListResponse.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

//reading status related

///Returns a http response containing all reading statuses of all manga
///followed by the user identified by the [sessionToken]
///The [sessionToken] can be obtained using the login() function.
Future<http.Response> getAllMangaReadingStatusResponse(
    String sessionToken, String? status) async {
  var unencodedPath =
      status == null ? '/manga/status' : '/manga/status?status=$status';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

///Returns a [AllMangaReadingStatus] class instance containing all reading statuses of all manga
///followed by the user identified by the [sessionToken]
///The [sessionToken] can be obtained using the login() function.
Future<AllMangaReadingStatus> getAllUserMangaReadingStatus(String sessionToken,
    {ReadingStatus? readingStatus}) async {
  var status = '';
  if (readingStatus != null) {
    status = EnumUtils.parseStatusFromEnum(readingStatus);
  }
  var response = await getAllMangaReadingStatusResponse(sessionToken, status);
  try {
    return AllMangaReadingStatus.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Returns a [MangaReadingStatus] class instance containing the reading status
/// of a particular manga identified by [mangaId] or uuid
Future<MangaReadingStatus> getMangaReadingStatus(
    String sessionToken, String mangaId) async {
  var unencodedPath = '/manga/$mangaId/status';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
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
    String sessionToken, String mangaId, ReadingStatus? status) async {
  var statusString =
      status != null ? EnumUtils.parseStatusFromEnum(status) : 'reading';
  var unencodedPath = '/manga/$mangaId/status';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sessionToken',
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
Future<Result> removeMangaReadingStatus(
    String sessionToken, String mangaId) async {
  var statusString = '';
  var unencodedPath = '/manga/$mangaId/status';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken',
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
Future<Result> followManga(String sessionToken, String mangaId,
    {ReadingStatus? readingStatus}) async {
  var unencodedPath = '/manga/$mangaId/follow';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  try {
    await setMangaReadingStatus(sessionToken, mangaId, readingStatus);
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
Future<Result> unfollowManga(String sessionToken, String mangaId) async {
  var unencodedPath = '/manga/$mangaId/follow';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.delete(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
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
Future<ReadChapters> getAllReadChapters(
    String sessionToken, String mangaId) async {
  var unencodedPath = '/manga/$mangaId/read';
  final uri = 'https://$authority$unencodedPath?';

  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  try {
    return ReadChapters.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Returns a http response with details of all read chapters in the list of given [mangaIds] or uuids,
///please note it returns a http response since the response is not always of the same schema.
Future<http.Response> getAllReadChaptersForAListOfManga(
    String sessionToken, List<String> mangaIds) async {
  var unencodedPath = '/manga/read';
  var _ids = '';
  mangaIds.forEach((element) {
    _ids = _ids + '&ids[]=$element';
  });
  final uri = 'https://$authority$unencodedPath?$_ids';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

///Mark a chapter identified by it's [chapterId] or uuid as READ
Future<Result> markChapterRead(String sessionToken, String chapterId) async {
  var unencodedPath = '/chapter/$chapterId/read';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
      },
      body: jsonEncode({'id': '$chapterId'}));
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Mark a chapter identified by it's [chapterId] or uuid as UNREAD
Future<Result> markChapterUnread(String sessionToken, String chapterId) async {
  var unencodedPath = '/chapter/$chapterId/read';
  final uri = 'https://$authority$unencodedPath';
  var response = await http.delete(Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
      },
      body: jsonEncode({'id': '$chapterId'}));
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Marks multiple chapters in the list of [chapterIds] or uuids as READ
Future<Result> markMultipleChaptersRead(
    String sessionToken, String mangaId, List<String> chapterIds) async {
  var idList = [];
  chapterIds.forEach((element) {
    idList.add(element);
  });
  var payload = {
    'chapterIdsRead': chapterIds.toString(),
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
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

///Marks multiple chapters in the list of [chapterIds] or uuids as UNREAD
Future<Result> markMultipleChaptersUnread(
    String sessionToken, String mangaId, List<String> chapterIds) async {
  var idList = [];
  chapterIds.forEach((element) {
    idList.add(element);
  });
  var payload = {
    'chapterIdsRead': chapterIds.toString(),
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
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

//Custom Lists related

///Creates a custom list with the name [listName] and
///sets visibility to either [Visibility.private] or
///[Visibility.public] and adds all mangas IDs / UUIDs
///in the [mangaIds] list and returns a http response
///containing data of the list created.
Future<http.Response> createCustomListResponse(
    String sessionToken,
    String listName,
    Visibility visibility,
    List<String> mangaIds,
    int version) async {
  var payload = {HttpHeaders.authorizationHeader: 'Bearer $sessionToken'};
  var body = {
    'name': listName,
    'visibility': EnumUtils.parseVisibilityFromEnum(visibility),
    'manga': mangaIds,
    'version': version,
  };
  var unencodedPath = '/list';
  final uri = 'https://$authority$unencodedPath';
  return await http.post(Uri.parse(uri), headers: payload, body: body);
}

///Creates a custom list with the name [listName] and
///sets visibility to either [Visibility.private] or
///[Visibility.public] and adds all mangas IDs / UUIDs
///in the [mangaIds] list and returns a [SingleCustomListResponse]
///class instance containing data of the list created.
Future<SingleCustomListResponse> createCustomList(
    String sessionToken,
    String listName,
    Visibility visibility,
    List<String> mangaIds,
    int version) async {
  var response = await createCustomListResponse(
      sessionToken, listName, visibility, mangaIds, version);
  try {
    return SingleCustomListResponse.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Gets the data of the custom list identified by it's [listId]
///or list uuid and returns a http response containing the data.

Future<http.Response> getCustomListResponse(String listId) async {
  var unencodedPath = '/list/$listId';
  final uri = 'https://$authority$unencodedPath';
  return await http.get(Uri.parse(uri));
}

///Gets the data of the customList identified by it's [listId]
///or list uuid and returns a [SingleCustomListResponse]containing the data.
Future<SingleCustomListResponse> getCustomList(String listId) async {
  var response = await getCustomListResponse(listId);
  try {
    return SingleCustomListResponse.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Updates an existing custom list identified by its [listId] or UUID
/// only if the user identified by the [sessionToken] has permission to
/// update the list and returns the updated data in a http response.
Future<http.Response> updateCustomListResponse(
    String sessionToken,
    String listId,
    String listName,
    Visibility visibility,
    List<String> mangaIds,
    int version) async {
  var payload = {
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken',
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  var body = {
    'name': listName,
    'visibility': EnumUtils.parseVisibilityFromEnum(visibility),
    'manga': mangaIds,
    'version': version,
  };
  var unencodedPath = '/list';
  final uri = 'https://$authority$unencodedPath';
  return await http.put(Uri.parse(uri), headers: payload, body: body);
}

/// Updates an existing custom list identified by its [listId] or UUID
/// only if the user identified by the [sessionToken] has permission to
/// update the list and returns the updated data in a [SingleCustomListResponse]
/// class instance.
Future<SingleCustomListResponse> updateCustomList(
    String sessionToken,
    String listId,
    String listName,
    Visibility visibility,
    List<String> mangaIds,
    int version) async {
  var response = await updateCustomListResponse(
      sessionToken, listId, listName, visibility, mangaIds, version);
  try {
    return SingleCustomListResponse.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

/// Deletes a list identified by it's [listId] only
/// if the user identified by the [sessionToken] is
/// eligible to do so and retuns a http response.
Future<http.Response> deleteCustomListResponse(
  String sessionToken,
  String listId,
) async {
  var payload = {
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken',
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  var unencodedPath = '/list/$listId';
  final uri = 'https://$authority$unencodedPath';
  return await http.delete(Uri.parse(uri), headers: payload);
}

/// Deletes a list identified by it's [listId] only
/// if the user identified by the [sessionToken] is
/// eligible to do so and retuns a [Result] instance
/// containing info on whether the request was successful.
Future<Result> deleteCustomList(String sessionToken, String listId) async {
  var response = await deleteCustomListResponse(sessionToken, listId);
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Makes the user identified by the [sessionToken] follow
///a custom list identified by it's [listId] and returns a
///http response.
Future<http.Response> followCustomListResponse(
  String sessionToken,
  String listId,
) async {
  var payload = {
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken',
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  var unencodedPath = '/list/$listId/follow';
  final uri = 'https://$authority$unencodedPath';
  return await http.post(Uri.parse(uri), headers: payload);
}

///Makes the user identified by the [sessionToken] follow
///a custom list identified by it's [listId] and returns a
///[Result] class instance containing info on whether the request was successful.
Future<Result> followCustomList(String sessionToken, String listId) async {
  var response = await followCustomListResponse(sessionToken, listId);
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Makes the user identified by the [sessionToken] unfollow
///a custom list identified by it's [listId] and returns a
///http response.
Future<http.Response> unfollowCustomListResponse(
  String sessionToken,
  String listId,
) async {
  var payload = {
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken',
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  var unencodedPath = '/list/$listId/follow';
  final uri = 'https://$authority$unencodedPath';
  return await http.delete(Uri.parse(uri), headers: payload);
}

///Makes the user identified by the [sessionToken] unfollow
///a custom list identified by it's [listId] and returns a
///[Result] class instance containing info on whether the request was successful.
Future<Result> unfollowCustomList(String sessionToken, String listId) async {
  var response = await unfollowCustomListResponse(sessionToken, listId);
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Adds a manga identified by it's [mangaId] / UUID to a custom list identified by
///it's [listId] if the user identified by the [sessionToken]
///has the permission to do so and returns a http response.
Future<http.Response> addMangaToCustomListResponse(
  String sessionToken,
  String mangaId,
  String listId,
) async {
  var payload = {
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken',
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  var unencodedPath = '/manga/$mangaId/list/$listId';
  final uri = 'https://$authority$unencodedPath';
  return await http.post(Uri.parse(uri), headers: payload);
}

///Adds a manga identified by it's [mangaId] / UUID to a custom list identified by
///it's [listId] if the user identified by the [sessionToken]
///has the permission to do so and returns a [Result]
///class instance containing info on whether the request was successful.
Future<Result> addMangaToCustomList(
    String sessionToken, String mangaId, String listId) async {
  var response =
      await addMangaToCustomListResponse(sessionToken, mangaId, listId);
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Removes a manga identified by it's [mangaId] / UUID to a custom list identified by
///it's [listId] if the user identified by the [sessionToken]
///has the permission to do so and returns a http response.
Future<http.Response> removeMangaFromCustomListResponse(
  String sessionToken,
  String mangaId,
  String listId,
) async {
  var payload = {
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken',
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  var unencodedPath = '/manga/$mangaId/list/$listId';
  final uri = 'https://$authority$unencodedPath';
  return await http.delete(Uri.parse(uri), headers: payload);
}

///Removes a manga identified by it's [mangaId] / UUID to a custom list identified by
///it's [listId] if the user identified by the [sessionToken]
///has the permission to do so and returns a [Result] class instance
///containing info on whether the request was successful.
Future<Result> removeMangaFromCustomList(
    String sessionToken, String mangaId, String listId) async {
  var response =
      await removeMangaFromCustomListResponse(sessionToken, mangaId, listId);
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Get's [limit] number of PUBLIC custom lists of a user identified by
///it's [userId] counting from list [offset] and returns a http response.
Future<http.Response> getUserCustomListsResponse(
    String userId, int? limit, int? offset) async {
  var _limit = limit == null ? '' : '&limit=$limit';
  var _offset = offset == null ? '' : '&offset=$offset';
  final unencodedPath = '/user/$userId/list';
  final uri = 'https://$authority$unencodedPath?$_limit$_offset';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  });
  return response;
}

///Get's [limit] number of PUBLIC custom lists of a user identified by
///it's [userId] counting from list [offset] and returns a
///[SingleCustomListResponse] class instance containing the details of the lists.
Future<SingleCustomListResponse> getUserCustomLists(
    String userId, int? limit, int? offset) async {
  var response = await getUserCustomListsResponse(userId, limit, offset);
  try {
    return SingleCustomListResponse.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

//Author related

/// Search for an author by the author's [name] and return [limit] number of results (10 by default) in a http response.
Future<http.Response> searchAuthorResponse(
  String? name,
  int? limit,
  int? offset,
  List<String>? ids,
  List<String>? includes,
) async {
  var _name = (name == null) ? '' : '&name=$name';
  var _limit = (limit == null) ? '' : '&limit=$limit';
  var _offset = (offset == null) ? '' : '&offset=$offset';
  var _ids = '';
  if (ids != null) {
    ids.forEach((element) {
      _ids = _ids + '&ids[]=$element';
    });
  }
  var _includes = '';
  if (includes != null) {
    includes.forEach((element) {
      _includes = _includes + '&includes[]=$element';
    });
  }

  final unencodedPath = '/author';
  final uri =
      'https://$authority$unencodedPath?$_name$_limit$_offset$_ids$_includes';
  var response = http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  });
  return response;
}

/// Search for an author by the author's [name] and return [limit] number of results (10 by default)
/// in an [AuthorSearchResult] class instance.
Future<AuthorSearchResult> searchAuthor(
  String? name,
  int? limit,
  int? offset,
  List<String>? ids,
  List<String>? includes,
) async {
  var response = await searchAuthorResponse(name, limit, offset, ids, includes);
  return AuthorSearchResult.fromJson(jsonDecode(response.body));
}

///Get details of an author identified by the author's [authorId] or UUID nad return the data as an http response.
Future<http.Response> getAuthorByIdResponse(String authorId) async {
  final unencodedPath = '/author/$authorId';
  final uri = 'https://$authority$unencodedPath';
  var response = http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  });
  return response;
}

///Get details of an author identified by the author's [authorId] or UUID nad return the data
///in an [AuthorInfo] class instance.
Future<AuthorInfo> getAuthorById(String authorId) async {
  var response = await getAuthorByIdResponse(authorId);
  try {
    return AuthorInfo.fromJson(jsonDecode(response.body));
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
