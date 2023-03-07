///A simple library to facilitate easier access to the mangadex REST API (https://api.mangadex.org) for flutter and dart apps
///
///mangadex_library is in no way officially affiliated or recommended by mangadex.

library mangadex_library;

import 'dart:convert';
import 'dart:io';

import 'package:mangadex_library/models/aggregate/Aggregate.dart';
import 'package:mangadex_library/models/common/order_enums.dart';

import 'mangadexServerException.dart';
import 'enum_utils.dart';

import 'package:http/http.dart' as http;

import '/models/author/author_info.dart';
import '/models/author/author_search_results.dart';
import '/models/common/visibility.dart';
import '/models/custom_lists/custom_list_confirmation.dart';
import '/models/login/token_check.dart';
import '/models/scanlation/scanlation.dart';
import '/models/scanlation/scanlationsResult.dart';
import '/models/user/user_feed/user_feed.dart';
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
/// user has permissions.
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

Future<http.Response> logoutResponse(String sessionToken) async {
  var unencodedPath = '/auth/login';
  var uri = 'https://$authority$unencodedPath';
  var response = await http.post(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
  return response;
}

Future<Result> logout(String sessionToken) async {
  var response = await logoutResponse(sessionToken);
  try {
    return Result.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

// Manga search related functions

Future<http.Response> searchResponse({
  String? title,
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
  Map<SearchOrders, OrderDirections>? orders,
  bool? hasAvailableChapters,
}) async {
  var unencodedPath = '/manga';
  var _title = title != null ? '&title=$title' : '';
  var _authors = '';
  if (authors != null) {
    authors.forEach((element) {
      _authors = _authors + '&authors[]=$element';
    });
  }
  var _limit = limit != null ? '&limit=$limit' : '';
  var _offset = offset != null ? '&offset=$offset' : '';
  var _artists = '';
  if (artists != null) {
    artists.forEach((element) {
      _artists = _artists + '&artists[]=$element';
    });
  }
  var _year = year != null ? '&year=$year' : '';
  var _includedTags = '';
  if (includedTags != null) {
    includedTags.forEach((element) {
      _includedTags = _includedTags + '&includedTags[]=$element';
    });
  }
  var _publicationDemographic = '';
  if (publicationDemographic != null) {
    publicationDemographic.forEach((element) {
      _publicationDemographic = _publicationDemographic +
          '&publicationDemographic[]=${EnumUtils.parsePublicDemographicFromEnum(element)}';
    });
  }
  var _includedTagsMode = '';
  if (includedTagsMode != null) {
    _includedTagsMode = EnumUtils.parseTagModeFromEnum(includedTagsMode);
  }
  var _excludedTags = '';
  if (excludedTags != null) {
    excludedTags.forEach((element) {
      _excludedTags = _excludedTags + '&excludedTags[]=$element';
    });
  }
  var _excludedTagsMode = '';
  if (excludedTagsMode != null) {
    _excludedTagsMode = EnumUtils.parseTagModeFromEnum(excludedTagsMode);
  }
  var _status = '';
  if (status != null) {
    status.forEach((element) {
      _status =
          _status + '&status[]=${EnumUtils.parseMangaStatusFromEnum(element)}';
    });
  }

  var _originalLanguage = '';
  if (originalLanguage != null) {
    originalLanguage.forEach((element) {
      _originalLanguage = _originalLanguage +
          '&originalLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }
  var _excludedOriginalLanguage = '';
  if (excludedOriginalLanguages != null) {
    excludedOriginalLanguages.forEach((element) {
      _excludedOriginalLanguage = _excludedOriginalLanguage +
          '&excludedOriginalLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }
  var _availableTranslatedLanguage = '';
  if (availableTranslatedLanguage != null) {
    availableTranslatedLanguage.forEach((element) {
      _availableTranslatedLanguage = _availableTranslatedLanguage +
          '&availableTranslatedLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }

  var _ids = '';
  if (ids != null) {
    ids.forEach((element) {
      _ids = _ids + '&ids[]=$element';
    });
  }
  var _contentRating = '';
  if (contentRating != null) {
    contentRating.forEach((element) {
      _contentRating = _contentRating +
          '&contentRating[]=${EnumUtils.parseContentRatingFromEnum(element)}';
    });
  }
  var _includes = '';
  if (includes != null) {
    includes.forEach((element) {
      _includes = _includes + '&includes[]=$element';
    });
  }
  var _createdAtSince =
      createdAtSince != null ? '&createdAtSince=$createdAtSince' : '';
  var _updatedAtSince =
      updatedAtSince != null ? '&updatedAtSince=$updatedAtSince' : '';
  var _group = group != null ? '&group=$group' : '';
  var _order = '';
  if (orders != null) {
    orders.entries.forEach((element) {
      _order = _order +
          '&order[${EnumUtils.parseSearchOrdersFromEnum(element.key)}]=${EnumUtils.parseOrderDirectionFromEnum(element.value)}';
    });
  } else {
    _order = '&order[latestUploadedChapter]=desc';
  }

  final url =
      'https://$authority$unencodedPath?$_title$_limit$_offset$_authors$_artists$_year$_includedTags$_includedTagsMode$_excludedTags$_excludedTagsMode$_status$_originalLanguage$_excludedOriginalLanguage$_availableTranslatedLanguage$_publicationDemographic$_ids$_contentRating$_createdAtSince$_updatedAtSince$_includes$_group$_order';
  var httpResponse = await http.get(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return httpResponse;
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
  Map<SearchOrders, OrderDirections>? orders,
}) async {
  var response = await searchResponse(
    title: query,
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
    orders: orders,
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
Future<http.Response> getChaptersResponse(
  String mangaId, {
  List<String>? ids,
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
  Map<ChapterOrders, OrderDirections>? orders,
  int? limit,
  int? offset,
}) async {
  var unencodedPath = '/chapter';
  var _mangaId = mangaId;
  var _limit = limit != null ? '&limit=$limit' : '&limit=10';
  var _offset = offset != null ? '&offset=$offset' : '&offset=0';
  var _ids = '';
  if (ids != null) {
    ids.forEach((element) {
      _ids = _ids + '&ids[]=$element';
    });
  }
  var _title = title != null ? '&title=$title' : '';
  var _groups = '';
  if (groups != null) {
    groups.forEach((element) {
      _groups = _groups + '&groups[]=$element';
    });
  }
  var _uploader = uploader != null ? '&uploader=$uploader' : '';
  var _volume = volume != null ? '&volume=$volume' : '';
  var _chapter = chapter != null ? '&chapter=$chapter' : '';

  var _translatedLanguage = '';
  if (translatedLanguage != null) {
    translatedLanguage.forEach((element) {
      _translatedLanguage = _translatedLanguage +
          '&translatedLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }
  var _originalLanguage = '';
  if (originalLanguage != null) {
    originalLanguage.forEach((element) {
      _originalLanguage = _originalLanguage +
          '&originalLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }
  var _excludedOriginalLanguage = '';
  if (excludedOriginalLanguage != null) {
    excludedOriginalLanguage.forEach((element) {
      _excludedOriginalLanguage = _excludedOriginalLanguage +
          '&excludedOriginalLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }
  var _contentrating = '';
  if (contentRating != null) {
    contentRating.forEach((element) {
      _contentrating = _contentrating +
          '&contentRating[]=${EnumUtils.parseContentRatingFromEnum(element)}';
    });
  }

  var _createdAtSince =
      createdAtSince != null ? '&createdAtSince=$createdAtSince' : '';
  var _updatedAtSince =
      updatedAtSince != null ? '&updatedAtSince=$updatedAtSince' : '';
  var _publishedAtSince =
      publishedAtSince != null ? '&publishedAtSince=$publishedAtSince' : '';
  var _includes = includes != null ? '&includes[]=$includes' : '';
  var _order = '';
  if (orders != null) {
    orders.entries.forEach((element) {
      _order = _order +
          '&order[${EnumUtils.parseChapterOrdersFromEnum(element.key)}]=${EnumUtils.parseOrderDirectionFromEnum(element.value)}';
    });
  }

  final url =
      'https://$authority$unencodedPath?&manga=$_mangaId$_limit$_offset$_ids$_title$_groups$_uploader$_volume$_chapter$_translatedLanguage$_createdAtSince$_updatedAtSince$_publishedAtSince$_includes';
  var response = await http.get(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  return response;
}

///gets [limit] number of chapters and their data for the given [mangaId] or uuid,
///mangas can be filtered by their [groups], [uploader], [volume], or [chapter].
///
///They can also be filtered by their [translatedLanguage], [originalLanguage], [excludedOriginalLanguage],
///and even their [contentRating] or by date with [createdAtSince], [updatedAtSince], [publishedAtSince] parameters.
///
///Returns the manga data in a [ChapterData] class instance.
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
    Map<ChapterOrders, OrderDirections>? orders,
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
    orders: orders,
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
String constructPageUrl(
    String baseUrl, bool dataSaver, String chapterHash, String filename) {
  var dataMode = dataSaver ? 'data-saver' : 'data';
  return '$baseUrl/$dataMode/$chapterHash/$filename';
}

/// Gets the chapter filenames just using the [chapterId] of a chapter.
/// returns a [List] of [String] containing all the file names of a chapter.
@Deprecated('Use [getChapterDataByChapterId] instead')
Future<List<String>> getChapterFilenames(
    String chapterId, bool isDataSaverMode) async {
  var response = await getChapterDataByChapterId(chapterId);
  if (isDataSaverMode == true) {
    return response.chapter.dataSaver;
  } else {
    return response.chapter.data;
  }
}

///Gets response of manga chapter and volume info of a manga identified by it's [mangaId],
///which can be filtered by [groupIds] and [translatedLanguages]
Future<http.Response> getMangaAggregateResponse(String mangaId,
    {List<String>? groupIds, List<LanguageCodes>? translatedLanguages}) async {
  var _groupIds = '';
  var _translatedLanguages = '';
  if (groupIds != null) {
    groupIds.forEach((element) {
      _groupIds = _groupIds + '&groups[]=$element';
    });
  }
  if (translatedLanguages != null) {
    translatedLanguages.forEach((element) {
      _translatedLanguages = _translatedLanguages +
          '&translatedLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(element)}';
    });
  }
  var unencodedPath =
      '/manga/$mangaId/aggregate?$_groupIds$_translatedLanguages';
  var uri = 'https://$authority$unencodedPath';
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  });
  return response;
}

///Gets response of manga chapter and volume info of a manga identified by it's [mangaId],
///which can be filtered by [groupIds] and [translatedLanguages]
Future<Aggregate> getMangaAggregate(String mangaId,
    {List<String>? groupIds, List<LanguageCodes>? translatedLanguages}) async {
  var response = await getMangaAggregateResponse(
    mangaId,
    groupIds: groupIds,
    translatedLanguages: translatedLanguages,
  );
  try {
    return Aggregate.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

// Manga cover art related functions

///returns a https response with cover art details for a manga with given [mangaIds] or uuid,
///it can also take multiple [coverIds] and get their details at once, cover arts can also be
///filtered by a list of [uploaders] and [locales]
Future<http.Response> getCoverArtResponse(
  List<String> mangaIds, [
  List<String>? coverIds,
  List<String>? uploaders,
  List<String>? locales,
  Map<CoverOrders, OrderDirections>? orders,
  int? limit,
  int? offset,
]) async {
  var _limit = limit == null ? '?limit=10' : '?limit=$limit';
  var _offset = offset == null ? '' : '&offset=$offset';
  var _mangasIds = '';
  mangaIds.forEach((element) {
    _mangasIds = _mangasIds + '&manga[]=$element';
  });
  var _coverIds = '';
  if (coverIds != null) {
    coverIds.forEach((element) {
      _coverIds = _coverIds + '&cover[]=$element';
    });
  }
  var _uploaders = '';
  if (uploaders != null) {
    uploaders.forEach((element) {
      _uploaders = _uploaders + '&uploaders[]=$element';
    });
  }
  var _locales = '';
  if (locales != null) {
    locales.forEach((element) {
      _locales = _locales + '&locales[]=$element';
    });
  }
  var _order = '';
  if (orders != null) {
    orders.entries.forEach((element) {
      _order = _order +
          '&order[${EnumUtils.parseCoverOrdersFromEnum(element.key)}]=${EnumUtils.parseOrderDirectionFromEnum(element.value)}';
    });
  } else {
    _order = '';
  }
  final uri =
      'https://$authority/cover$_limit$_offset$_mangasIds$_coverIds$_locales$_uploaders$_order';
  print(uri);
  var response = await http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  });
  return response;
}

///returns an [Cover] class instance containing cover
///art details for a manga with given [mangaIds] or uuid
Future<Cover> getCoverArt(
  List<String> mangaIds, {
  List<String>? coverIds,
  List<String>? uploaders,
  List<String>? locales,
  Map<CoverOrders, OrderDirections>? order,
  int? limit,
  int? offset,
}) async {
  var response = await getCoverArtResponse(
      mangaIds, coverIds, uploaders, locales, order, limit, offset);
  try {
    return Cover.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Directly get Cover art details of a manga with [mangaIds]
///and return a [Map<String, String>] containing values with
///manga IDs mapped to their cover art filenames.

Future<Map<String, String>> getCoverArtUrlMap(
  List<String> mangaIds,
) async {
  var data = await search(ids: mangaIds, includes: ['cover_art']);

  var map = <String, String>{};

  for (final manga in data.data) {
    final searchVal = manga.relationships
        .where((element) => element.attributes != null)
        .toList();
    map.addEntries(
      [
        MapEntry(manga.id, searchVal[0].attributes!.fileName),
      ],
    );
  }

  print('''
Note this function only gives a Map of the manga ids mapped to their cover filenames.
You must use constructPageUrl() in utils and pass the map to it to get the urls. ''');

  return map;
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
  String? status;
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

/// Set the reading status for a certain manga to [status]
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

///Mark a chapter identified by it's [chapterId] or uuid as READ <br><br>
///DEPRECATION WARNING: The end point `POST /chapter/{id}/read` is deprecated as is to be removed by 02-10-2022<br>
///Which makes this function deprecated and on schedule to be removed as well.
@Deprecated('Use [markChapterReadOrUnread] instead')
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

///Mark a chapter identified by it's [chapterId] or uuid as UNREAD <br><br>
///DEPRECATION WARNING: The end point `DELETE /chapter/{id}/read` is deprecated as is to be removed by 2-10-2022<br>
///Which makes this function deprecated and on schedule to be removed as well.
@Deprecated('Use [markChapterReadOrUnread] instead')
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

/// Marks a chapter of a manga identified by it's [mangaId] as read or unread
/// for user identified by their [sessionToken].
///
/// [chapterIdsRead] should be an
/// array of chapterIDs to be marked as READ and [chapterIdsUnread] should be
/// an array of chapterIDs to be marked as UNREAD.
Future<Result> markChapterReadOrUnRead(String mangaId, String sessionToken,
    {List<String>? chapterIdsRead, List<String>? chapterIdsUnread}) async {
  if ((chapterIdsRead != null && chapterIdsRead.isEmpty) &&
      (chapterIdsUnread != null && chapterIdsUnread.isEmpty)) {
    throw Exception(
        'Both chapterIdsRead and ChapterIdsUnread CANNOT be empty, atleast one list must be non-null and must have atleast one chapterID.');
  } else {
    chapterIdsRead = chapterIdsRead ?? [];
    chapterIdsUnread = chapterIdsUnread ?? [];
    var unencodedPath = '/manga/$mangaId/read';
    var body = jsonEncode({
      'chapterIdsRead': chapterIdsRead,
      'chapterIdsUnread': chapterIdsUnread,
    });
    final uri = 'https://$authority$unencodedPath';
    var response = await http.post(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $sessionToken',
      },
      body: body,
    );
    try {
      return Result.fromJson(jsonDecode(response.body));
    } on Exception {
      throw MangadexServerException(jsonDecode(response.body));
    }
  }
}

///Marks multiple chapters in the list of [chapterIds] or uuids as READ
@Deprecated('Use markChapterReadOrUnRead() instead')
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
@Deprecated('Use markChapterReadOrUnRead() instead')
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

//scanlation group related

///Search for a scanlation group with the [name] and returns [limit] number of results
///from [offset] which may focus on the given [focussedLanguage] and returns a http response.
Future<http.Response> getScanlationGroupResponse({
  int? limit = 10,
  int? offset,
  List<String>? ids,
  String? name,
  LanguageCodes? focussedLanguage,
  List<String>? includes,
  Map<ScanlationOrders, OrderDirections>? order,
}) {
  var _limit = limit == null ? 'limit=10' : 'limit=$limit';
  var _offset = offset == null ? '' : '&offset=$offset';
  var _ids = '';
  if (ids != null) {
    ids.forEach((element) {
      _ids = _ids + '&ids[]=$element';
    });
  }
  var _name = name == null ? '' : '&name=$name';
  var _focussedLanguage = focussedLanguage == null
      ? ''
      : '&focussedLanguage=${EnumUtils.parseLanguageCodeFromEnum(focussedLanguage)}';
  var _includes = '';
  if (includes != null) {
    includes.forEach((element) {
      _includes = _includes + '&includes[]=$element';
    });
  }
  var _order = '';
  (order != null)
      ? order.entries.forEach((element) {
          _order = _order +
              '&order[${EnumUtils.parseScanlationOrderEnum(element.key)}]=${EnumUtils.parseOrderDirectionFromEnum(element.value)}';
        })
      : _order = '&order[latestUploadedChapter]=desc';

  var unenecodedPath = '/group';
  var uri =
      'https://$authority$unenecodedPath?$_limit$_offset$_ids$_name$_focussedLanguage$_order';
  return http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  });
}

///Search for a scanlation group with the [name] and returns [limit] number of results
///from [offset] which may focus on the given [focussedLanguage] and returns a
///[ScanlationsResult] class instance that contains all the information.
Future<ScanlationsResult> getScanlationGroup({
  int? limit,
  int? offset,
  List<String>? ids,
  String? name,
  LanguageCodes? focussedLanguage,
  List<String>? includes,
  Map<ScanlationOrders, OrderDirections>? order,
}) async {
  var response = await getScanlationGroupResponse(
    limit: limit,
    offset: offset,
    ids: ids,
    name: name,
    focussedLanguage: focussedLanguage,
    includes: includes,
    order: order,
  );
  try {
    return ScanlationsResult.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Creates  a Scanlation Group managed by the user identified by it's [sessionToken] or UUID
///and returns an http response containing the group's information after being created.
Future<http.Response> createScanlationGroupResponse(
  String name,
  String website,
  String ircServer,
  String ircChannel,
  String discord,
  String contactEmail,
  String description,
  String twitter,
  String mangaUpdates,
  bool inactive,
  String publishDelay,
  String sessionToken,
) {
  var unencodedPath = '/group';
  var uri = 'https://$authority$unencodedPath';
  return http.post(Uri.parse(uri), headers: {
    'name': name,
    'website': website,
    'ircServer': ircServer,
    'ircChannel': ircChannel,
    'discord': discord,
    'contactEmail': contactEmail,
    'description': description,
    'twitter': twitter,
    'mangaUpdates': mangaUpdates,
    'inactive': inactive.toString(),
    'publishDelay': publishDelay,
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
  });
}

///Creates  a Scanlation Group managed by the user identified by it's [sessionToken] or UUID
///and returns an http response containing the group's information after being created.
Future<Scanlation> createScanlationGroup({
  required String name,
  required String website,
  required String ircServer,
  required String ircChannel,
  required String discord,
  required String contactEmail,
  required String description,
  required String twitter,
  required String mangaUpdates,
  required bool inactive,
  required String publishDelay,
  required String sessionToken,
}) async {
  var response = await createScanlationGroupResponse(
    name,
    website,
    ircServer,
    ircChannel,
    discord,
    contactEmail,
    description,
    twitter,
    mangaUpdates,
    inactive,
    publishDelay,
    sessionToken,
  );
  try {
    return Scanlation.fromJson(jsonDecode(response.body));
  } on Exception {
    throw MangadexServerException(jsonDecode(response.body));
  }
}

///Returns an http response containing info of a Scanlation Group identified by it's [groupId] or UUID
Future<http.Response> getScanlationGroupByIdResponse(String groupId) {
  var unencodedPath = '/group/$groupId';
  var uri = 'https://$authority$unencodedPath';
  return http.get(Uri.parse(uri), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  });
}

///Returns an [Scanlation] class instance containing info of a Scanlation Group identified by it's [groupId] or UUID
Future<Scanlation> getScanlationGroupById(String groupId) async {
  var response = await getScanlationGroupByIdResponse(groupId);
  try {
    return Scanlation.fromJson(jsonDecode(response.body));
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
