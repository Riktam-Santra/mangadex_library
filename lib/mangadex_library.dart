import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:mangadex_library/src/repositories/auth_repository.dart';
import 'package:mangadex_library/src/repositories/repository.dart';
import 'package:mangadex_library/src/models/login/login.dart';

class MangadexClient extends Repositories {
  final bool autoSave;
  final Directory? saveDirectory;
  final String? filename;
  final bool autoRefresh;
  final Duration? refreshDuration;

  Token? _token;
  late Timer _refreshTimer;

  MangadexClient(
      {this.autoRefresh = true,
      this.refreshDuration,
      this.autoSave = false,
      this.saveDirectory,
      this.filename}) {
    if (saveDirectory != null && filename != null && autoSave != false) {
      loadFromLocation(saveDirectory!, filename)
          .then((value) => _token = value);
    }
    _refreshTimer =
        Timer.periodic(refreshDuration ?? Duration(minutes: 14), (timer) async {
      if (_token != null) {
        try {
          _token = (await refresh(_token!.refresh!)).token;
          log("Token Refreshed");
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
