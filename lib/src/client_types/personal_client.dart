import 'dart:async';

import 'package:mangadex_library/mangadex_client.dart';
import 'package:mangadex_library/src/repositories/auth_repository.dart';

/// Creates a Personal Mangadex Client (https://api.mangadex.org/docs/02-authentication/personal-clients/)
/// This class requires you to enter a client ID and a client Secret, both can be generated from your
/// mangadex account. The class extends [MangadexClient] which is the base building class for all clients.
class MangadexPersonalClient extends MangadexClient {
  late String? _clientId;
  late String? _clientSecret;
  MangadexPersonalClient(
      {String? clientId,
      String? clientSecret,

      /// whether to automatically refresh the user tokens or not
      bool autoRefresh = true,

      /// interval between token refreshes
      /// defaults to 14 minutes
      Duration? refreshDuration,

      /// A function that executes on successful refresh of token
      void Function()? onRefresh})
      : super(
            autoRefresh: autoRefresh,
            onRefresh: onRefresh,
            refreshDuration: refreshDuration) {
    _clientId = clientId;
    _clientSecret = clientSecret;
    if (_clientId != null && _clientSecret != null) {
      super.setTimer(Timer.periodic(refreshDuration ?? Duration(minutes: 14),
          (timer) async {
        if (super.tokenIsNotNull()) {
          try {
            super.setToken(
              await AuthRepository.refreshForPersonalClient(
                  super.token!.refreshToken, _clientId!, _clientSecret!),
            );
            if (onRefresh != null) {
              onRefresh();
            }
          } on Exception {
            super.setToken(null);
            rethrow;
          }
        }
      }));
    } else {
      super.setToken(null);
    }
  }

  void setClientID(String? clientId) => _clientId = clientId;
  void setClientSecret(String? clientSecret) => _clientId = clientSecret;

  Future<void> login(String username, String password) async {
    if (_clientId == null || _clientSecret == null) {
      throw Exception('ClientId or ClientSecret was not set');
    }
    final authResponse = await AuthRepository.loginPersonalClient(
        username, password, _clientId!, _clientSecret!);
    super.setToken(authResponse);
  }

  Future<void> refresh(String refreshToken) async {
    if (_clientId == null || _clientSecret == null) {
      throw Exception('ClientId or ClientSecret was not set');
    }
    super.setToken(await AuthRepository.refreshForPersonalClient(
        refreshToken, _clientId!, _clientSecret!));
  }
}
