import 'dart:convert';
import 'dart:io';

import '../../mangadex_server_exception.dart';
import '../constants/authority.dart';
import '../models/common/result_ok.dart';
import '../models/login/token.dart';
import 'package:http/http.dart' as http;

import '../models/login/token_check.dart';

mixin AuthRepository {
  /// Endpoint used: `POST /realms/mangadex/protocol/openid-connect/token`
  ///
  /// Takes in a [refreshToken] token and returns a *http response* of a new refresh token
  static Future<Token> loginPersonalClient(String username, String password,
      String clientId, String clientSecret) async {
    final unencodedPath = '/realms/mangadex/protocol/openid-connect/token';
    final uri = 'https://$AUTH_AUTHORITY$unencodedPath';
    var response = await http.post(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
    }, body: {
      'grant_type': 'password',
      'username': username,
      'password': password,
      'client_id': clientId,
      'client_secret': clientSecret
    });
    return Token.fromJson(jsonDecode(response.body));
  }

  /// Endpoint used: `POST /realms/mangadex/protocol/openid-connect/token`
  ///
  /// Takes in a [refreshToken] token and returns a *http response* of a new refresh token
  @Deprecated(
      'This function is deprecated until further actions are taken my mangadex to introduce the new login methods')
  static Future<http.Response> getRefreshResponse(String refreshToken) async {
    final unencodedPath = '/realms/mangadex/protocol/openid-connect/token';
    final uri = 'https://$AUTHORITY$unencodedPath';
    var response = await http.post(Uri.parse(uri),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({'token': '$refreshToken'}));
    return response;
  }

  static Future<http.Response> getRefreshResponseForPersonalClient(
      String refreshToken, String clientId, String clientSecret) async {
    final unencodedPath = '/realms/mangadex/protocol/openid-connect/token';
    final uri = 'https://$AUTH_AUTHORITY$unencodedPath';
    var response = await http.post(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
      },
      body: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
        'client_id': clientId,
        'client_secret': clientSecret
      },
    );
    return response;
  }

  /// Endpoint used: `POST /auth/refresh`
  ///
  /// Takes in a refresh token and returns a [Token] class instance
  /// containing the new token
  @Deprecated(
      'This function is deprecated until further actions are taken my mangadex to introduce the new login methods')
  static Future<Token> refresh(String refreshToken) async {
    var response = await getRefreshResponse(refreshToken);
    try {
      return Token.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw MangadexServerException(jsonDecode(response.body));
    }
  }

  static Future<Token> refreshForPersonalClient(
      String refreshToken, String clientId, String clientSecret) async {
    var response = await getRefreshResponseForPersonalClient(
        refreshToken, clientId, clientSecret);
    try {
      return Token.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw MangadexServerException(jsonDecode(response.body));
    }
  }

  /// Endpoint used: `GET /auth/check`
  ///
  /// Returns an http response with data on whether the [sessionToken] is authenticated and the
  /// user has permissions.
  static Future<http.Response> checkTokenResponse(String sessionToken) async {
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
  static Future<AuthenticationCheck> checkToken(String sessionToken) async {
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
  static Future<http.Response> logoutResponse(String sessionToken) async {
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
  static Future<Result> logout(String sessionToken) async {
    var response = await logoutResponse(sessionToken);
    try {
      return Result.fromJson(jsonDecode(response.body));
    } on Exception {
      throw MangadexServerException(jsonDecode(response.body));
    }
  }
}
