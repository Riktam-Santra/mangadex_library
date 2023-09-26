import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../enums/reading_status.dart';
import '../models/aggregate/aggregate.dart';
import '../models/chapter/read_chapters.dart';
import '../models/common/all_manga_reading_status.dart';
import '../models/common/manga_reading_status.dart';
import '../models/common/result_ok.dart';
import '../models/feed/manga_feed.dart';
import '../util/enum_utils.dart';
import '../../mangadex_server_exception.dart';
import '../constants/authority.dart';
import '../enums/content_rating.dart';
import '../enums/language_codes.dart';
import '../enums/manga_status.dart';
import '../enums/order_enums.dart';
import '../enums/publication_demographic.dart';
import '../enums/tag_modes.dart';
import '../models/common/single_manga_data.dart';
import '../models/search/search.dart';

mixin MangaRepository {
  /// Endpoint used: `GET /manga`
  ///
  ///Gets manga search results
  ///takes in optional parameters to filter out content
  ///and returns the query data in a [Search] class instance
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
        _status = _status +
            '&status[]=${EnumUtils.parseMangaStatusFromEnum(element)}';
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
        'https://$AUTHORITY$unencodedPath?$_title$_limit$_offset$_authors$_artists$_year$_includedTags$_includedTagsMode$_excludedTags$_excludedTagsMode$_status$_originalLanguage$_excludedOriginalLanguage$_availableTranslatedLanguage$_publicationDemographic$_ids$_contentRating$_createdAtSince$_updatedAtSince$_includes$_group$_order';
    var httpResponse = await http.get(Uri.parse(url),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    return httpResponse;
  }

  /// Endpoint used: `GET /manga`
  ///
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

  /// Endpoint used: `GET /manga/{id}`
  ///
  ///gets details of a manga with the given [mangaId] or uuid
  ///Returns the manga data in a [SingleMangaData] class instance
  Future<SingleMangaData> getMangaDataByMangaId(String mangaId) async {
    var unencodedPath = '/manga/$mangaId';
    var response = await http.get(Uri.http(AUTHORITY, unencodedPath));
    try {
      return SingleMangaData.fromJson(jsonDecode(response.body));
    } on Exception {
      throw MangadexServerException(jsonDecode(response.body));
    }
  }

  /// Endpoint used: `GET /manga/{id}/aggregate`
  ///
  ///Gets response of manga chapter and volume info of a manga identified by it's [mangaId],
  ///which can be filtered by [groupIds] and [translatedLanguages]
  Future<http.Response> getMangaAggregateResponse(String mangaId,
      {List<String>? groupIds,
      List<LanguageCodes>? translatedLanguages}) async {
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
    var uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return response;
  }

  /// Endpoint used: `GET /manga/{id}/aggregate`
  ///
  ///Gets response of manga chapter and volume info of a manga identified by it's [mangaId],
  ///which can be filtered by [groupIds] and [translatedLanguages]
  Future<Aggregate> getMangaAggregate(String mangaId,
      {List<String>? groupIds,
      List<LanguageCodes>? translatedLanguages}) async {
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

  /// Endpoint used: `GET /manga/status`
  ///
  ///Returns a http response containing all reading statuses of all manga
  ///followed by the user identified by the [sessionToken]
  ///The [sessionToken] can be obtained using the login() function.
  Future<http.Response> getAllMangaReadingStatusResponse(
      String sessionToken, String? status) async {
    var unencodedPath =
        status == null ? '/manga/status' : '/manga/status?status=$status';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
    });
    return response;
  }

  /// Endpoint used: `GET /manga/status`
  ///
  ///Returns a [AllMangaReadingStatus] class instance containing all reading statuses of all manga
  ///followed by the user identified by the [sessionToken]
  ///The [sessionToken] can be obtained using the login() function.
  Future<AllMangaReadingStatus> getAllUserMangaReadingStatus(
      String sessionToken,
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

  /// Endpoint used: `GET /manga/{id}/status`
  ///
  /// Returns a [MangaReadingStatus] class instance containing the reading status
  /// of a particular manga identified by [mangaId] or uuid
  Future<MangaReadingStatus> getMangaReadingStatus(
      String sessionToken, String mangaId) async {
    var unencodedPath = '/manga/$mangaId/status';
    final uri = 'https://$AUTHORITY$unencodedPath';
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

  /// Endpoint used: `POST /manga/{id}/status`
  ///
  /// Set the reading status for a certain manga to [status]
  /// If no reading status is supplied to it, the reading status is set as 'reading'
  Future<Result> setMangaReadingStatus(
      String sessionToken, String mangaId, ReadingStatus? status) async {
    var statusString =
        status != null ? EnumUtils.parseStatusFromEnum(status) : 'reading';
    var unencodedPath = '/manga/$mangaId/status';
    final uri = 'https://$AUTHORITY$unencodedPath';
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

  /// Endpoint used: `DELETE /manga/{id}/aggregate`
  ///
  /// remove the reading status for a certain manga
  /// If no reading status is supplied to it, the reading status is set as 'reading'
  Future<Result> removeMangaReadingStatus(
      String sessionToken, String mangaId) async {
    var statusString = '';
    var unencodedPath = '/manga/$mangaId/status';
    final uri = 'https://$AUTHORITY$unencodedPath';
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

  /// Endpoint used: `POST /manga/{id}/follow`
  ///
  ///Follow a manga identified by [mangaId] and optionally set a reading status for it.
  ///
  ///If no [readingStatus] is specified, the reading status is set to 'reading' by default
  Future<Result> followManga(String sessionToken, String mangaId,
      {ReadingStatus? readingStatus}) async {
    var unencodedPath = '/manga/$mangaId/follow';
    final uri = 'https://$AUTHORITY$unencodedPath';
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

  /// Endpoint used: `DELETE /manga/{id}/aggregate`
  ///
  /// Unfollow a manga identified by [mangaId] or uuid
  Future<Result> unfollowManga(String sessionToken, String mangaId) async {
    var unencodedPath = '/manga/$mangaId/follow';
    final uri = 'https://$AUTHORITY$unencodedPath';
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
    final uri = 'https://$AUTHORITY$unencodedPath?';

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
    final uri = 'https://$AUTHORITY$unencodedPath?$_ids';
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
    final uri = 'https://$AUTHORITY$unencodedPath';
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
  Future<Result> markChapterUnread(
      String sessionToken, String chapterId) async {
    var unencodedPath = '/chapter/$chapterId/read';
    final uri = 'https://$AUTHORITY$unencodedPath';
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
      final uri = 'https://$AUTHORITY$unencodedPath';
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
    final uri = 'https://$AUTHORITY$unencodedPath';
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
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.post(Uri.parse(uri), headers: payload);
    try {
      return Result.fromJson(jsonDecode(response.body));
    } on Exception {
      throw MangadexServerException(jsonDecode(response.body));
    }
  }

  /// Endpoint used: `GET /manga/{id}/feed`
  ///
  /// Gets the feed of a give [mangaId] and returns the
  /// response body of the data received.
  Future<http.Response> getMangaFeedResponse(
    String mangaId, {
    int? limit,
    int? offset,
    List<LanguageCodes>? translatedLanguage,
    List<LanguageCodes>? originalLanguage,
    List<LanguageCodes>? excludedOriginalLanguage,
    List<ContentRating>? contentRating,
    List<String>? excludedGroups,
    List<String>? excludedUploaders,
    bool? includeFutureUpdates,
    String? createdAtSince,
    String? updatedAtSince,
    String? publishAtSince,
    Map<ChapterOrders, OrderDirections>? order,
    List<String>? includes,
    bool? includeEmptyPages,
    bool? includeFuturePublishAt,
    bool? includeExternalUrl,
  }) async {
    var _limit =
        ((limit ?? 100) <= 100) ? '?limit=${limit ?? 100}' : '?limit=100';
    var _offset = ((offset == null) ? '' : '&offset=$offset');

    var _translatedLanguage = '';
    for (final lang in translatedLanguage ?? []) {
      _translatedLanguage +=
          '&translatedLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(lang)}';
    }

    var _originalLanguage = '';
    for (final lang in originalLanguage ?? []) {
      _originalLanguage +=
          '&originalLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(lang)}';
    }

    var _excludedOriginalLanguage = '';
    for (final lang in excludedOriginalLanguage ?? []) {
      _excludedOriginalLanguage +=
          '&excludedOriginalLanguage[]=${EnumUtils.parseLanguageCodeFromEnum(lang)}';
    }

    var _contentRating = '';
    for (final rating in contentRating ??
        [
          ContentRating.safe,
          ContentRating.suggestive,
          ContentRating.erotica,
        ]) {
      _contentRating +=
          '&contentRating[]=${EnumUtils.parseContentRatingFromEnum(rating)}';
    }

    var _excludedGroups = '';
    for (final group in excludedGroups ?? []) {
      '&excludedGroups[]=$group';
    }

    var _excludedUploaders = '';
    for (final group in excludedUploaders ?? []) {
      '&excludedUploaders[]=$group';
    }

    var _createdAtSince =
        createdAtSince == null ? '' : '&createdAtSince=$createdAtSince';

    var _updatedAtSince =
        updatedAtSince == null ? '' : '&updatedAtSince=$updatedAtSince';

    var _publishAtSince =
        publishAtSince == null ? '' : '&publishAtSince=$publishAtSince';

    var _order = '';
    (order ??
            {
              ChapterOrders.createdAt: OrderDirections.ascending,
              ChapterOrders.updatedAt: OrderDirections.ascending,
              ChapterOrders.publishAt: OrderDirections.ascending,
              ChapterOrders.readableAt: OrderDirections.ascending,
              ChapterOrders.volume: OrderDirections.ascending,
              ChapterOrders.chapter: OrderDirections.ascending
            })
        .entries
        .forEach((element) {
      _order = _order +
          '&order[${EnumUtils.parseChapterOrdersFromEnum(element.key)}]=${EnumUtils.parseOrderDirectionFromEnum(element.value)}';
    });

    var _includeFutureUpdates = includeFutureUpdates == null
        ? ''
        : includeFutureUpdates
            ? '&includeFutureUpdates=1'
            : '&includeFutureUpdates=0';

    var _includeEmptyPages = includeEmptyPages == null
        ? ''
        : includeEmptyPages
            ? '&includeEmptyPages=1'
            : '&includeEmptyPages=0';

    var _includeFuturePublishAt = includeFuturePublishAt == null
        ? ''
        : includeFuturePublishAt
            ? '&includeFuturePublishAt=1'
            : '&includeFuturePublishAt=0';
    var _includeExternalUrl = includeExternalUrl == null
        ? ''
        : includeExternalUrl
            ? '&includeExternalUrl=1'
            : '&includeExternalUrl=0';

    var unencodedpath = '/manga/$mangaId/feed';
    var uri =
        'https://$AUTHORITY$unencodedpath$_limit$_offset$_translatedLanguage$_originalLanguage$_excludedOriginalLanguage$_contentRating$_excludedGroups$_excludedUploaders$_includeFutureUpdates$_order$_createdAtSince$_updatedAtSince$_publishAtSince$_includeEmptyPages$_includeFuturePublishAt$_includeExternalUrl';
    return await http.get(Uri.parse(uri));
  }

  /// Endpoint used: `GET /manga/{id}/feed`
  ///
  ///Gets the manga feed for the the given [mangaId] of a manga
  ///and returns a [MangaFeed] class instance of the data.
  Future<MangaFeed> getMangaFeed(
    String mangaId, {
    int? limit,
    int? offset,
    List<LanguageCodes>? translatedLanguage,
    List<LanguageCodes>? originalLanguage,
    List<LanguageCodes>? excludedOriginalLanguage,
    List<ContentRating>? contentRating,
    List<String>? excludedGroups,
    List<String>? excludedUploaders,
    bool? includeFutureUpdates,
    String? createdAtSince,
    String? updatedAtSince,
    String? publishAtSince,
    Map<ChapterOrders, OrderDirections>? order,
    List<String>? includes,
    bool? includeEmptyPages,
    bool? includeFuturePublishAt,
    bool? includeExternalUrl,
  }) async {
    var response = await getMangaFeedResponse(mangaId,
        limit: limit,
        offset: offset,
        translatedLanguage: translatedLanguage,
        originalLanguage: originalLanguage,
        excludedOriginalLanguage: excludedOriginalLanguage,
        contentRating: contentRating,
        excludedGroups: excludedGroups,
        excludedUploaders: excludedUploaders,
        includeFutureUpdates: includeFutureUpdates,
        createdAtSince: createdAtSince,
        updatedAtSince: updatedAtSince,
        publishAtSince: publishAtSince,
        order: order,
        includes: includes,
        includeEmptyPages: includeEmptyPages,
        includeFuturePublishAt: includeFuturePublishAt,
        includeExternalUrl: includeExternalUrl);
    return MangaFeed.fromJson(jsonDecode(response.body));
  }
}
