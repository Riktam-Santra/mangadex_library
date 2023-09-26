import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../mangadex_server_exception.dart';
import '../constants/authority.dart';
import '../models/author/author_info.dart';
import '../models/author/author_search_results.dart';

mixin AuthorRepository {
//Author related
  /// Endpoint used: `GET /author`
  ///
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
        'https://$AUTHORITY$unencodedPath?$_name$_limit$_offset$_ids$_includes';
    var response = http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return response;
  }

  /// Endpoint used: `GET /author/{id}`
  ///
  /// Search for an author by the author's [name] and return [limit] number of results (10 by default)
  /// in an [AuthorSearchResults] class instance.
  Future<AuthorSearchResults> searchAuthor(
    String? name,
    int? limit,
    int? offset,
    List<String>? ids,
    List<String>? includes,
  ) async {
    var response =
        await searchAuthorResponse(name, limit, offset, ids, includes);
    return AuthorSearchResults.fromJson(jsonDecode(response.body));
  }

  ///Get details of an author identified by the author's [authorId] or UUID nad return the data as an http response.
  Future<http.Response> getAuthorByIdResponse(String authorId) async {
    final unencodedPath = '/author/$authorId';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return response;
  }

  /// Endpoint used: `GET /author/{id}`
  ///
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
}
