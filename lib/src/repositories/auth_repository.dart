import 'dart:convert';
import 'dart:io';

import '../../mangadex_server_exception.dart';
import '../constants/authority.dart';
import '../models/common/result_ok.dart';
import '../models/login/login.dart';
import 'package:http/http.dart' as http;

import '../models/login/token_check.dart';

mixin AuthRepository {
  /// Endpoint used: `POST /auth/login`
  ///
  /// Returns the a [Login] class instance with a JWT session and refresh token for [username].
  @Deprecated(
      'This function is deprecated until further actions are taken my mangadex to introduce the new login methods')
  static Future<Login> login(String username, String password) async {
    var response = await loginResponse(username, password);
    try {
      return Login.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw MangadexServerException(jsonDecode(response.body));
    }
  }

  /// Endpoint used: `POST /auth/login`
  ///
  /// Returns the a http request of a JWT token for [username].
  ///
  /// Will return null if the requests fails.
  @Deprecated(
      'This function is deprecated until further actions are taken my mangadex to introduce the new login methods')
  static Future<http.Response> loginResponse(
      String username, String password) async {
    var unencodedPath = '/auth/login';
    var response = await http.post(
      Uri.https(AUTHORITY, unencodedPath),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
        {'username': '$username', 'password': '$password'},
      ),
    );
    return response;
  }

  /// Endpoint used: `POST /auth/refresh`
  ///
  /// Takes in a [refreshToken] token and returns a *http response* of a new refresh token
  @Deprecated(
      'This function is deprecated until further actions are taken my mangadex to introduce the new login methods')
  Future<http.Response> getRefreshResponse(String refreshToken) async {
    final unencodedPath = '/auth/refresh';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.post(Uri.parse(uri),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({'token': '$refreshToken'}));
    return response;
  }

  /// Endpoint used: `POST /auth/refresh`
  ///
  /// Takes in a refresh token and returns a [Login] class instance
  /// containing the new token
  @Deprecated(
      'This function is deprecated until further actions are taken my mangadex to introduce the new login methods')
  Future<Login> refresh(String refreshToken) async {
    var response = await getRefreshResponse(refreshToken);
    try {
      return Login.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw MangadexServerException(jsonDecode(response.body));
    }
  }

  /// Endpoint used: `GET /auth/check`
  ///
  /// Returns an http response with data on whether the [sessionToken] is authenticated and the
  /// user has permissions.
  Future<http.Response> checkTokenResponse(String sessionToken) async {
    final unencodedPath = '/auth/check';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.get(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
    });
    return response;
  }

  /// Endpoint used: `GET /auth/check`
  ///
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

  /// Endpoint used: `POST /auth/logout`
  ///
  ///Logs out the user pointed out by [sessionToken] and returns the response body
  Future<http.Response> logoutResponse(String sessionToken) async {
    var unencodedPath = '/auth/logout';
    var uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.post(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $sessionToken'
    });
    return response;
  }

  /// Endpoint used: `POST /auth/logout`
  ///
  ///Logs out the user pointed out by [sessionToken] and returns a [Result] class instance of the body
  Future<Result> logout(String sessionToken) async {
    var response = await logoutResponse(sessionToken);
    try {
      return Result.fromJson(jsonDecode(response.body));
    } on Exception {
      throw MangadexServerException(jsonDecode(response.body));
    }
  }
}
