import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../mangadex_server_exception.dart';
import '../constants/authority.dart';
import '../enums/order_enums.dart';
import '../models/cover/cover.dart';
import '../util/enum_utils.dart';

mixin CoverRepository {
  /// Endpoint used: `GET /cover`
  ///
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
        'https://$AUTHORITY/cover$_limit$_offset$_mangasIds$_coverIds$_locales$_uploaders$_order';
    print(uri);
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return response;
  }

  /// Endpoint used: `GET /cover`
  ///
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
}
