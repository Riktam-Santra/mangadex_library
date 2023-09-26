import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../mangadex_server_exception.dart';
import '../constants/authority.dart';
import '../enums/visibility.dart';
import '../models/common/result_ok.dart';
import '../models/custom_lists/single_custom_list_response.dart';
import '../util/enum_utils.dart';

mixin ListRepository {
  /// Endpoint used: `POST /list`
  ///
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
    final uri = 'https://$AUTHORITY$unencodedPath';
    return await http.post(Uri.parse(uri), headers: payload, body: body);
  }

  /// Endpoint used: `POST /list`
  ///
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

  /// Endpoint used: `GET /list/{id}/`
  ///
  ///Gets the data of the custom list identified by it's [listId]
  ///or list uuid and returns a http response containing the data.
  Future<http.Response> getSingleCustomListResponse(String listId) async {
    var unencodedPath = '/list/$listId';
    final uri = 'https://$AUTHORITY$unencodedPath';
    return await http.get(Uri.parse(uri));
  }

  ///Gets the data of the customList identified by it's [listId]
  ///or list uuid and returns a [SingleCustomListResponse]containing the data.
  Future<SingleCustomListResponse> getSingleCustomList(String listId) async {
    var response = await getSingleCustomListResponse(listId);
    try {
      return SingleCustomListResponse.fromJson(jsonDecode(response.body));
    } on Exception {
      throw MangadexServerException(jsonDecode(response.body));
    }
  }

  /// Endpoint used: `PUT /list/{id}`
  ///
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
    final uri = 'https://$AUTHORITY$unencodedPath';
    return await http.put(Uri.parse(uri), headers: payload, body: body);
  }

  /// Endpoint used: `PUT /manga/{id}/aggregate`
  ///
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

  /// Endpoint used: `DELETE /list/{id}`
  ///
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
    final uri = 'https://$AUTHORITY$unencodedPath';
    return await http.delete(Uri.parse(uri), headers: payload);
  }

  /// Endpoint used: `DELETE /list/{id}`
  ///
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

  /// Endpoint used: `POST /list/{id}/follow`
  ///
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
    final uri = 'https://$AUTHORITY$unencodedPath';
    return await http.post(Uri.parse(uri), headers: payload);
  }

  /// Endpoint used: `POST /list/{id}/follow`
  ///
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

  /// Endpoint used: `DELETE /list/{id}/follow`
  ///
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
    final uri = 'https://$AUTHORITY$unencodedPath';
    return await http.delete(Uri.parse(uri), headers: payload);
  }

  /// Endpoint used: `DELETE /loist/{id}/follow`
  ///
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

  /// Endpoint used: `POST /manga/{id}/list/{id}`
  ///
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
    final uri = 'https://$AUTHORITY$unencodedPath';
    return await http.post(Uri.parse(uri), headers: payload);
  }

  /// Endpoint used: `POST /manga/{id}/list/{id}`
  ///
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

  /// Endpoint used: `DELETE /manga/{id}/list/{id}`
  ///
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
    final uri = 'https://$AUTHORITY$unencodedPath';
    return await http.delete(Uri.parse(uri), headers: payload);
  }

  /// Endpoint used: `DELETE /manga/{id}/list/{id}`
  ///
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
}
