import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mangadex_library/src/constants/authority.dart';

import '../util/enum_utils.dart';
import '../../mangadex_server_exception.dart';
import '../enums/content_rating.dart';
import '../enums/language_codes.dart';
import '../enums/order_enums.dart';
import '../models/chapter/chapter_data.dart';

mixin ChapterRepository {
  /// Endpoint used: `GET /chapter`
  ///
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
        'https://$AUTHORITY$unencodedPath?&manga=$_mangaId$_limit$_offset$_ids$_title$_groups$_uploader$_volume$_chapter$_translatedLanguage$_createdAtSince$_updatedAtSince$_publishedAtSince$_includes';
    var response = await http.get(Uri.parse(url),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    return response;
  }

  /// Endpoint used: `GET /chapter`
  ///
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
}
