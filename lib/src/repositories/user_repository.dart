import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../mangadex_server_exception.dart';
import '../constants/authority.dart';
import '../models/custom_lists/single_custom_list_response.dart';
import '../models/user/logged_user_details/logged_user_details.dart';
import '../models/user/user_feed/user_feed.dart';
import '../models/user/user_followed_groups/user_followed_groups.dart';
import '../models/user/user_followed_manga/user_followed_manga.dart';
import '../models/user/user_followed_users/user_followed_users.dart';

mixin UserRepository {
  /// Endpoint used: `GET /user/me`
  ///
  /// Returns a http response of the user details associated with the [sessionToken]
  Future<http.Response> getLoggedUserDetailsResponse(
      String sessionToken) async {
    final unencodedPath = '/user/me';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
    });
    return response;
  }

  /// Endpoint used: `GET /auth/check`
  ///
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

  /// Endpoint used: `GET /user/follows/manga`
  ///
  ///Directly get Cover art details of a manga with [mangaIds]
  ///and return a [Map<String, String>] containing values with
  ///manga IDs mapped to their cover art filenames.

// User related functions

  /// Get a http response of the all the Manga user follows,
  /// the [sessionToken] is the session token obtained using the login() function
  Future<http.Response> getUserFollowedMangaResponse(String sessionToken,
      {int? offset, int? limit}) async {
    final _offset = '&offset=${offset ?? 0}';
    final _limit = '&limit=${limit ?? 10}';
    final unencodedPath = '/user/follows/manga?$_offset$_limit';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
    });
    return response;
  }

  /// Endpoint used: `GET /user/follows/manga/{id}`
  ///
  ///Simply check if the user identified by the current session [sessionToken]
  ///follows a manga with [mangaId] or uuid and return a http response
  Future<http.Response> checkIfUserFollowsMangaResponse(
      String sessionToken, String mangaId) async {
    final unencodedPath = '/user/follows/manga/$mangaId';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
    });
    return response;
  }

  /// Endpoint used: `GET /user/follows/manga/{id}`
  ///
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

  /// Endpoint used: `GET /manga/{id}/aggregate`
  ///
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

  /// Endpoint used: `GET /user/follows/user`
  ///
  /// Returns a http response of the all the Users that the user follows,
  /// the [sessionToken] is the session token obtained using the login function
  /// of the client.
  Future<http.Response> getUserFollowedUsersResponse(String sessionToken,
      {int? offset, int? limit}) async {
    final _offset = '&offset=${offset ?? 0}';
    final _limit = '&limit=${limit ?? 10}';
    final unencodedPath = '/user/follows/user?$_offset$_limit';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
    });
    return response;
  }

  /// Endpoint used: `GET /user/follows/user`
  ///
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

  /// Endpoint used: `GET /user/follows/user/{id}`
  ///
  ///Returns a http response of whether the user identified by the current session [sessionToken]
  ///follows a User with [userId] or uuid and return a http response
  Future<http.Response> checkIfUserFollowsUserResponse(
      String sessionToken, String userId) async {
    final unencodedPath = '/user/follows/user/$userId';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
    });
    return response;
  }

  /// Endpoint used: `GET /user/follows/user/{id}`
  ///
  ///Simply check if the user identified by the current session [sessionToken]
  ///follows a User with [userId] or uuid and return a bool
  Future<bool> checkIfUserFollowsUser(
      String sessionToken, String userId) async {
    var response = await checkIfUserFollowsUserResponse(sessionToken, userId);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      return false;
    } else {
      throw MangadexServerException(jsonDecode(response.body));
    }
  }

  /// Endpoint used: `GET /user/follows/group`
  ///
  /// Returns a http response with details of the all the Groups that the user follows,
  /// the [sessionToken] is the session token obtained using the login() function
  Future<http.Response> getUserFollowedGroupsResponse(String sessionToken,
      {int? offset, int? limit}) async {
    final _offset = '&offset=${offset ?? 0}';
    final _limit = '&limit=${limit ?? 10}';
    final unencodedPath = '/user/follows/group?$_offset$_limit';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
    });
    return response;
  }

  /// Endpoint used: `GET /user/follows/group`
  ///
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

  /// Endpoint used: `GET /user/follows/group/{id}`
  ///
  ///Simply check if the user identified by the current session [sessionToken]
  ///follows a Group with [groupId] or uuid and return a http response
  Future<http.Response> checkIfUserFollowsGroupResponse(
      String sessionToken, String groupId) async {
    final unencodedPath = '/user/follows/group/$groupId';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
    });
    return response;
  }

  /// Endpoint used: `GET /user/follows/group/{id}`
  ///
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

  /// Endpoint used: `GET /user/follows/manga/feed`
  ///
  ///Returns a http response containing the user feed for the user
  ///identified by the [sessionToken].
  Future<http.Response> getUserFeedResponse(String sessionToken) async {
    final unencodedPath = '/user/follows/manga/feed';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
    });
    return response;
  }

  /// Endpoint used: `GET /user/follows/manga/feed`
  ///
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

  /// Endpoint used: `GET /user/list`
  ///
  /// Gets the [limit] number of custom lists from [offset]
  /// in the list of Custom Lists of the user identified
  /// by the [sessionToken] and returns a http response
  /// containing the data.
  Future<http.Response> getLoggedInUserCustomListsResponse(
      String sessionToken, int? limit, int? offset) async {
    var _limit = limit == null ? '' : '?limit=$limit';
    var _offset = offset == null ? '' : '&offset=$offset';
    final unencodedPath = '/user/list';
    final uri = 'https://$AUTHORITY$unencodedPath$_limit$_offset';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
    });
    return response;
  }

  /// Endpoint used: `GET /user/list`
  ///
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

  /// Endpoint used: `GET /user/{id}/list`
  ///
  ///Get's [limit] number of PUBLIC custom lists of a user identified by
  ///it's [userId] counting from list [offset] and returns a http response.
  Future<http.Response> getUserCustomListsResponse(
      String userId, int? limit, int? offset) async {
    var _limit = limit == null ? '' : '&limit=$limit';
    var _offset = offset == null ? '' : '&offset=$offset';
    final unencodedPath = '/user/$userId/list';
    final uri = 'https://$AUTHORITY$unencodedPath?$_limit$_offset';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return response;
  }

  /// Endpoint used: `get /user/{id}/list`
  ///
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
}
