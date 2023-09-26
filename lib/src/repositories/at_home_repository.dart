import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../mangadex_server_exception.dart';
import '../constants/authority.dart';
import '../models/common/base_url.dart';

mixin AtHomeRepository {
  /// Endpoint used: `GET /at-home/server/{id}`
  ///
// Functions to get base url for a chapter ID

  ///Returns a http response of Base URL for [chapterId] or uuid
  Future<http.Response> getBaseUrlResponse(String chapterId) async {
    var unencodedPath = '/at-home/server/$chapterId';
    var response = await http.get(Uri.https(AUTHORITY, unencodedPath),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    return response;
  }

  /// Endpoint used: `GET /at-home/server/{id}`
  ///
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
}
