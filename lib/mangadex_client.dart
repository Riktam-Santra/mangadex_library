import 'dart:async';

import 'package:mangadex_library/src/repositories/repository.dart';
import 'package:mangadex_library/src/models/login/token.dart';

export './mangadex_server_exception.dart';
export './src/enums/enums.dart';
export './src/models/models.dart';

class MangadexClient {
  final Repositories repositories;
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
      this.onRefresh}) : repositories = Repositories() {
    // if (saveDirectory != null && filename != null && autoSave != false) {
    //   loadFromLocation(saveDirectory!, filename)
    //       .then((value) => _token = value);
    // }
    _refreshTimer =
        Timer.periodic(refreshDuration ?? Duration(minutes: 14), (timer) async {
      if (_token != null) {
        try {
          _token = (await repositories.auth.refresh(_token!.refreshToken));
          if (onRefresh != null) {
            onRefresh!();
          }
        } on Exception {
          _token = null;
        }
      }
    });
  }

  void setToken(Token? token) {
    _token = token;
  }

  bool tokenIsNull() => _token == null;
  bool tokenIsNotNull() => _token != null;

  void setTimer(Timer timer) => _refreshTimer = timer;

  Token? get token => _token;


  String constructPageUrl(
      String baseUrl, bool dataSaver, String chapterHash, String filename) {
    var dataMode = dataSaver ? 'data-saver' : 'data';
    return '$baseUrl/$dataMode/$chapterHash/$filename';
  }


  void dispose() {
    _refreshTimer.cancel();
  }
}
