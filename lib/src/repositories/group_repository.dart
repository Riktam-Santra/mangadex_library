import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import '../../mangadex_server_exception.dart';
import '../constants/authority.dart';
import '../enums/language_codes.dart';
import '../enums/order_enums.dart';
import '../models/scanlation/scanlation.dart';
import '../models/scanlation/scanlations_result.dart';
import '../util/enum_utils.dart';

mixin GroupRepository {
//scanlation group related

  /// Endpoint used: `GET /group`
  ///
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
        'https://$AUTHORITY$unenecodedPath?$_limit$_offset$_ids$_name$_focussedLanguage$_order';
    return http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
  }

  /// Endpoint used: `GET /group`
  ///
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

  /// Endpoint used: `POST /group`
  ///
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
    var uri = 'https://$AUTHORITY$unencodedPath';
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

  /// Endpoint used: `POST /group`
  ///
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

  /// Endpoint used: `GET /group/{id}`
  ///
  ///Returns an http response containing info of a Scanlation Group identified by it's [groupId] or UUID
  Future<http.Response> getScanlationGroupByIdResponse(String groupId) {
    var unencodedPath = '/group/$groupId';
    var uri = 'https://$AUTHORITY$unencodedPath';
    return http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
  }

  /// Endpoint used: `GET /group/{id}`
  ///
  ///Returns an [Scanlation] class instance containing info of a Scanlation Group identified by it's [groupId] or UUID
  Future<Scanlation> getScanlationGroupById(String groupId) async {
    var response = await getScanlationGroupByIdResponse(groupId);
    try {
      return Scanlation.fromJson(jsonDecode(response.body));
    } on Exception {
      throw MangadexServerException(jsonDecode(response.body));
    }
  }
}
