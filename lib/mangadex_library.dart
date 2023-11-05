library mangadex_library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mangadex_library/src/repositories/auth_repository.dart';
import 'package:mangadex_library/src/repositories/repository.dart';
import 'package:mangadex_library/src/models/login/login.dart';

export './mangadex_server_exception.dart';
export './src/enums/enums.dart';
export './src/models/models.dart';

class MangadexClient extends Repositories {
  // Whether to autoSave tokens or not
  // final bool autoSave;

  // Directory to save user token to
  // final Directory? saveDirectory;

  // Name of file to save user token in
  // final String? filename;

  /// whether to automatically refresh the user tokens or not
  final bool autoRefresh;

  /// interval between token refreshes
  /// defaults to 14 minutes
  final Duration? refreshDuration;

  /// A function that executes on successful refresh of token
  final void Function()? onRefresh;

  Token? _token;
  late Timer _refreshTimer;

  MangadexClient(
      {this.autoRefresh = true,
      this.refreshDuration,
      // this.autoSave = false,
      // this.saveDirectory,
      // this.filename,
      this.onRefresh}) {
    // if (saveDirectory != null && filename != null && autoSave != false) {
    //   loadFromLocation(saveDirectory!, filename)
    //       .then((value) => _token = value);
    // }
    _refreshTimer =
        Timer.periodic(refreshDuration ?? Duration(minutes: 14), (timer) async {
      if (_token != null) {
        try {
          _token = (await refresh(_token!.refresh!)).token;
          if (onRefresh != null) {
            onRefresh!();
          }
        } on Exception {
          _token = null;
        }
      }
    });
  }

  /// Endpoint used: `POST /auth/login`
  ///
  /// Returns the a [Login] class instance with a JWT session and refresh token for [username].
  @Deprecated(
      'This function is deprecated until further actions are taken my mangadex to introduce the new login methods')
  Future<Login> login(String username, String password) async {
    var result = await AuthRepository.login(username, password);
    _token = result.token;
    return result;
  }

  static Future<void> saveToLocation(
      Token token, Directory directory, String? filename) async {
    var file = File(directory.path + (filename ?? 'userData.json'));
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
    await file.writeAsString(jsonEncode(token));
  }

  String constructPageUrl(
      String baseUrl, bool dataSaver, String chapterHash, String filename) {
    var dataMode = dataSaver ? 'data-saver' : 'data';
    return '$baseUrl/$dataMode/$chapterHash/$filename';
  }

  static Future<Token?> loadFromLocation(
      Directory directory, String? filename) async {
    var file = File(directory.path + (filename ?? 'userData.json'));
    if (await file.exists()) {
      var data = await file.readAsString();

      try {
        Map<String, dynamic> json = jsonDecode(data);
        return Token.fromJson(json);
      } on Exception {
        return null;
      }
    }
    return null;
  }

  void dispose() {
    _refreshTimer.cancel();
  }
}
